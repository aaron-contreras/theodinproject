require 'rails_helper'

RSpec.describe Admin::Flags::BanUser do
  subject(:service) { described_class.call(flag: flag) }

  let(:flag) { create(:flag, project_submission: project_submission) }
  let(:project_submission) { create(:project_submission, user: user) }
  let(:user) { create(:user) }

  describe '#call' do
    # Banned users must not be allowed to enter a project submission when
    # not a correct syntax/format for it.
    # Propose changes for complete css redecoratng and backend code structure.
    # No proper use of HTTP VERBS
    it 'sets the flagged project submission to banned' do
      expect { service }.to change { project_submission.banned }.from(false).to(true)
    end

    it 'sets the flagged project submissions owner to banned' do
      expect { service }.to change { user.banned }.from(false).to(true)
    end

    it 'sets the flags taken action to ban' do
      expect { service }.to change { flag.taken_action }.from('pending').to('ban')
    end

    it 'sets the flags status to resolved' do
      expect { service }.to change { flag.status }.from('active').to('resolved')
    end
  end

  describe '#success?' do
    it 'returns true' do
      expect(service.success?).to be(true)
    end
  end
end

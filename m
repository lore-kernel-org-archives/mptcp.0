Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAD72
	for <mptcp@lists.linux.dev>; Tue, 19 Oct 2021 17:08:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="252050854"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="252050854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 10:05:27 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="483325052"
Received: from mkharan-mobl.amr.corp.intel.com ([10.212.135.69])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 10:05:27 -0700
Date: Tue, 19 Oct 2021 10:05:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: Poorva Sonparote <psonparo@redhat.com>, mptcp@lists.linux.dev
Subject: Re: MPC+Data bug progress?
In-Reply-To: <YW597FiQlpiwZlrq@dcaratti.users.ipa.redhat.com>
Message-ID: <27e390a6-944f-6df7-d795-eaa09b418b1f@linux.intel.com>
References: <3f242ebc-3674-9468-f2b0-9fd756d54048@linux.intel.com> <CADppAWA7Mo-BwbE97Z1K=Ex3aK-_cbet6z12ObXVHj1wxEgxxQ@mail.gmail.com> <YW597FiQlpiwZlrq@dcaratti.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 19 Oct 2021, Davide Caratti wrote:

> On Mon, Oct 18, 2021 at 06:13:36PM -0700, Poorva Sonparote wrote:
>> Hi Mat,
>>
>> Due to some change in circumstances, I don't think I can get this fix out
>> in the required time frame. Can someone else please pick it up? Sorry about
>> this.
>
> hi Mat, Poorva,
>
> I can try to send a patch for this targeting kernel v5.15.

Ok, I appreciate that - thanks for the update.

--
Mat Martineau
Intel

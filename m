Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66619173
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 01:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641434053; x=1672970053;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZFgBUqtqZ3Z3kjgid40evuvyg8tQuAif309FxRvU0mE=;
  b=dqZphZafg/mlr75nrW+1Tk89Llq74vD9M838fDQN6W0E0y1zToPPXDri
   RetaN4A1JThSU6VpCfvr7AXBXREp0D9GdoM8fPH9rBLLKvJe2ataK++JO
   n+Q4pxXGlH1jrW8B2EJYFlErh0GA8rgo81VoSCaknwlK7Juty2ztnlgCj
   LrYjcMCqDpU5HMuXdeQ9zwIw4wpoRc6VOYQ6xHtJZAsQpa5pSnBb/4HdG
   26mkbBsvPNfPPYR7vw+nABBvFsKVBfMyYM64v44AyyaA/8ODmw7jMM5IZ
   XNuhBELy9/Ak+ieUxJ8+/qS3Z/sokngWvVvxA5On0gJUnORH7GOVxwX2N
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303322232"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="303322232"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:54:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="470783060"
Received: from rcamaril-mobl1.amr.corp.intel.com ([10.209.22.32])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:54:12 -0800
Date: Wed, 5 Jan 2022 17:54:12 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Upstreaming to net-next
Message-ID: <7b9cdfb-9ae6-287e-9e3e-7cf8e67e998d@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1057184331-1641434052=:38115"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1057184331-1641434052=:38115
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


As Matthieu noted in today's meeting, we need to figure out what goes 
upstream to netdev this week:

On Wed, 5 Jan 2022, Matthieu Baerts wrote:

> Patches to send to netdev:
>    - net:
>        - probably best to send:
>            - mptcp: fix opt size when sending DSS + MP_FAIL
>            - mptcp: fix a DSS option writing error → but we might need
> to change
>        - But if they are accepted after the last PR from Net maintainer
> to Linus would delay stuff.

I noticed that Jakub sent a "Networking for 5.16-final" pull request to 
Linus today, so the 5.16 ship has sailed.

>        - So if we don't want to rush to look at the tests, we can also
> send to net-next for the future -net (to be check which tree is merged
> in which one first?

The next pull requests from Jakub to Linus will be from net-next, so 
that's the fastest route to Linus' tree for fixes that will be added to 
the stable tree.


>
>    - net-next:
>        - patches from Paolo could go there, fixing issues, see GH
> issues/250:
>            - *@Paolo*: OK for you?
>
>        - + checksum fixes probably
>
>        - best to skip MP_FAIL series for now as we don't have a stable
> selftest yet
>
>        - and no need to send Mat's series as it is linked to new
> features in the Netlink PM part, not ready yet

Here are the commits that look ready (commit ids from 
export/20220105T054758):

Paolo:

9f6720406819 mptcp: keep snd_una updated for fallback socket
95bc19b21e00 mptcp: implement fastclose xmit path
37b1cee6f04f mptcp: full disconnect implementation
916957cdccd6 mptcp: cleanup accept and poll
6358b829913e mptcp: implement support for user-space disconnect
adba2e970980 selftests: mptcp: add disconnect tests
afef858f5fa4 mptcp: fix per socket endpoint accounting
9caba598fe7a mptcp: clean-up MPJ option writing
f584047ecf9a mptcp: keep track of local endpoint still available for each msk
fc51a4526843 mptcp: do not block subflows creation on errors
893d4cb7ccb9 selftests: mptcp: add tests for subflow creation failure
128e78db18bf mptcp: cleanup MPJ subflow list handling
e470b365da5f mptcp: avoid atomic bit manipulation when possible

3cdd8e644985 selftests: mptcp: more stable join tests-cases

Geliang:

e493c8de5c58 mptcp: change the parameter of __mptcp_make_csum
b79d45e020fd mptcp: reuse __mptcp_make_csum in validate_data_csum


Sound good? I may have to send in two batches so that patch count is not 
too large.

--
Mat Martineau
Intel
--0-1057184331-1641434052=:38115--

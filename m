Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794483479;
	b=D/EhHZRSe2FOo2ihcSLXTtdeq7QZAQog70nObvtsY35o8IEx2vtLew3+Bl1EpisPxvx6
	 GWWBdGY1p/cODVyKmAomqDAo3XNeV/StzEkxxFTxAmhcJRNxp+v0i5YSuvLlcGC3qNhsP
	 WU+9TUq16Ep1D/lFdVv+obeNG7w5UfDEHhKIpOlxOndAyi0DIzb2pkH4qMOCQVxDnF5gU
	 CK0pTZcA2sa0hLtxgllyykmDWR70kCtVE/AxjG0HvvZGQEnA8BStrDNB3MNaBsCCWFOZb
	 x6xf64/a8bn6V1K2sG39Kh4b/V8rvsg0ZAiFKDHdrAlPnBx6jJw0AmCOuC+yGwfFATA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483479;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=qd0im9VwEFNM1E1AtQWfdiu81k1e43WIoa1ubapivRY=;
	b=4FxhZXzMp4oOMgZDuHEhsHxnYgA8FDhNy75d9EV+Q3RpX/24fy0vEvfuKSkThUdY6HHJ
	 5gv5w1RFd+Amt3TvWu/u65KnHI80+LeX9yiTkacs6292dl6fy2b63iO6uEiX9vccB6b3o
	 bqT0nLbEgnqaDZIKYLVKAjJR8pzFKXsW15qfotsBWeBlRbOIAxXQPhQo2Wm+mljTWZnLC
	 TN9mU6czJkMs7Bugg5s1DCsNjoZwXvRnrr8iEKulmclzGj5sEY7MGjSTJm+QFcOFfsHwk
	 YYswJhS33ZRz2QoV/Ey/u5XFFmj0j5RTX2dLI8ox+0mHgzbmehD3SZiPV2Pas/LkWKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9F606A31C
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 11:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD9F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1794483472; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NRfemNpv+CnkYlPHkrZIBgUQjOplm39zxCGIDmwJwJAkyimO7Lo/Rh8wOY4hLL37vdIUy8iaCfebFkQkPTLEQNByUU+o2tcpRlPFolgR0MO+MRCXtqvJJOVSFsxlDAF0fV7pN2pawF3pjRelYw8/nXYaKhAGTe4/7G8jHDYoHyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794483472; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qd0im9VwEFNM1E1AtQWfdiu81k1e43WIoa1ubapivRY=; 
	b=GJF0pn6pOGZroyqwHpfzdbJBpVeXEPg29DP4x33Ec6XncVTe1NWQ/NnSLBxGnWH+l7OZxjWtR6hqUGbx1vJCIk3lqs4TJNEmigZAKbVbVJJvyBRFoZtDs+6LrshMQ5b903pQlbhIhAqieLf4mueA7AOISZghXUo5cFaiADiukKo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=syA9YGwSgCAhVPi3Un24DpKfgfE3yFeUW97ZJZHEBkVoeyx8dG5wOuV5xOomzC+uMAD7JzWKjq4bkBOlCpRX/HanF7ERuBYF+wFx04rmcdDBZL+ZWMwNMfOb8NBmZXv+3ZYC7SyOO5bY2GgxXxNaMcV5T04uYG74mHOcj3TcUKI=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=qd0im9VwEFNM1E1AtQWfdiu81k1e43WIoa1ubapivRY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1794483446266293.7674960274006; Thu, 12 Nov 2026 03:37:26 -0800 (PST)
Date: Thu, 12 Nov 2026 17:07:26 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a1cf8c61dd.83068f79144867.7028423115634706290@mpiricsoftware.com>
In-Reply-To: <08451824-13d5-4e92-adb6-2ebd6c5cf053@kernel.org>
References: <20261106111645.786225-1-kalpan.jani@mpiricsoftware.com> <1a1ce1e9b07.f015539104390.2600884748737974966@mpiricsoftware.com> <08451824-13d5-4e92-adb6-2ebd6c5cf053@kernel.org>
Subject: Re: [RFC net-next v12] mptcp: normalize sequence numbers using
 socket address
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

Thanks for reviewing and pointing this out.

Regarding the base commit, I understand the issue. My local patch was tested against a tree that is not present in your current mptcp_net-next tree. I will check the correct base and prepare the patch as a replacement for v11 rather than stacking it on top of v11.

Regarding the offset, I understand your concern about exposing information derived from the MPTCP socket address.

One alternative could be to use independent random offsets for the local and remote sequence-number directions, generated once per MPTCP connection and stored in the MPTCP socket structure. This would avoid deriving the offsets from a kernel address.

However, this introduces additional state and initialization requirements. We should also consider whether it preserves the expected semantics of the sequence numbers reported by MPTCP diagnostics.

Would retaining the existing `local_idsn` and `remote_idsn` values be preferable, or do you think independent per-direction random offsets are worth exploring?

I would appreciate your thoughts before I proceed with the next revision.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "shardul.b"<shardul.b@mpiricsoftware.com>, "janak"<janak@mpiric.us>, "kalpanjani009"<kalpanjani009@gmail.com>
Date: Thu, 12 Nov 2026 15:49:55 +0530
Subject: Re: [RFC net-next v12] mptcp: normalize sequence numbers using socket address

 > Hi Kalpan,
 > 
 > On 12/11/2026 05:57, Kalpan Jani wrote:
 > > Hi All,
 > > 
 > > I investigated the patch application failure locally.
 > > 
 > > The patch applies successfully to the intended base commit 27c69362083ec117ddb553c031e7f1e0e5d2105d.
 > > 
 > > I also tested both git apply --check and git apply --3way --check in a fresh detached worktree. Both tests passed, and all 12 files applied cleanly.
 > > Could you please check whether the CI environment has the expected base commit and the required Git blob objects available?
 > 
 > The base you mentions here is not in our tree:
 > 
 > 
 > https://github.com/multipath-tcp/mptcp_net-next/commit/27c69362083ec117ddb553c031e7f1e0e5d2105d
 > 
 > Also, it is not mentioned in the patch you sent. The CI cannot apply
 > this patch:
 > 
 > 
 > https://patchew.org/MPTCP/20261106111645.786225-1-kalpan.jani@mpiricsoftware.com/logs/git/
 > 
 > > The reported sha1 information is lacking or useless error may be related to the CI checkout or missing Git objects.
 > 
 > From what I see, the patch you sent is on top of the v11, instead of
 > replacing it.
 > 
 > Now, regarding the modifications -- even if it is hard to read -- the
 > offset using the msk address seems to be in place. Now that I'm thinking
 > about that, I'm afraid I might have given a bad direction: it is
 > probably not a good idea to give clues on the msk address while there
 > are many mechanisms in the kernel to hide that. Maybe we could take a
 > hash of this address? But that's costly: maybe we only want to do that
 > when coming from mptcp_diag_get_info? Also, we should probably have one
 > offset per direction (local/remote) not to be able to find out what's
 > the offset is when one direction is known. We could have a hash of the
 > msk address for one, and another hash coming from a XOR of the msk
 > address for example.
 > 
 > Any other ideas?
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 



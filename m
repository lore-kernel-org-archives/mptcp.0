Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794486770;
	b=WwfKnZ5TZiFrIgb5l2haMsO3KFCXLybL9nwXYKtrSX6TRh97rKoCbjYt+tPxTcuiVL17
	 5CAa2YTqhHDzJVkKHlc+U2LVV/X24H6IueYIAg4w0Nl97vEvBFMuzRzTdFXRQof0mn3Pe
	 9ZjwI9dak78QfG4RcF0ZXkm/s+9MIKpuw31tcUmEXdyA+ivfqkCxbpRlGMsvD/4LhtoFj
	 1E/mEGdjP4Z5PCsmOTFf/R/Y4vvoauC12sVAMj9aVoGTRDrc+KALgXPFnfK/qsN4nhjmZ
	 9BTVt/UrYnT2tuaQhFXMGGbWRMxni29qY2MtFlS5xZYO7X/e0sTP8G0eTgz/X+cfvxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486770;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=Vi5NBM3ndUUpa0WKlJ4j3FTBGdXvzfP2yJhWHHvvwrQ=;
	b=PWTnQpq699pDo90vMRkdokG8+cyjI5ytKN6XSdKce1tNr2KUQNxpMmIXuwY7Fyytt2B7
	 TvbJ75YiSYi76zfc9t7tlC9YMjSgp4vVZL9sTwSXFd+403IlhuLG3lcxxgWxSFK+m+lP8
	 fsrtSYC4YHYPMoKeDiMudiyR9GKreh5fDhvRbNQfWxxUcQaF2nzyPktZWFVEypUgcbSoe
	 WPFabXoritFIQgzt/RWNVb1Ac3z/X9bZEegjXMXmXXnxHTTqrtgmmfwA/V/Qqoehk1jpA
	 f4IeGW73qpMYHSuybgRn+Sw51T1MYjAlBUwpWllEhvOUfXW9qJ4ADy/OlkqPzIln56g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444E606A31C
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 12:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8444E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1794486767; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IVIS4/LYPzTEp+tZTCrz4HUTY8GSy+pXLxnBjsGhhfMvhf7voQHJfwUbpEvIKygo+ltJWfSjtbMYs+TMEp3FcuO973rlJm+a/GYUS5piQz4tYVEag9vYrXSEyABYd2LSsLttYAeU3YaELDRL2MTA14PeFE0GwqG4a37MxhnUEAw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794486767; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Vi5NBM3ndUUpa0WKlJ4j3FTBGdXvzfP2yJhWHHvvwrQ=; 
	b=TtmlZqrkpWKXHfsyOQQGb+GMJoy9UmkWEvIfwL7VBfTrRvoZQ2q5EoTK9zCa2puqgQijZrGHNxIxsybdjCPOLefUik9+O0/20AFu0zSusDcC2FZCSeRDzM6xgpysedCFVuymG6zQVng/AN0iJIGAXrGKF0MgoPXDlvjy91t8ig0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=AyIAu8UozcKulKbrscRnC6U8U8j/0XJzGvnwg9nhW5otc8RzrVqg5XTlI7zKMCCB2utigYG4O6uVgb/B4IOzEIuI+QfEeGPf2PWvFWZip/rK4TfI565Ug+LSgsyK5OoAaB4D0KMr2vdkzDePIPjH8HpCBMn/WltEC56JW/6qAPA=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=Vi5NBM3ndUUpa0WKlJ4j3FTBGdXvzfP2yJhWHHvvwrQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1794486765563662.4341629820027; Thu, 12 Nov 2026 04:32:45 -0800 (PST)
Date: Thu, 12 Nov 2026 18:02:45 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a1cfbf07cb.3c5744c95518.7332483156592200076@mpiricsoftware.com>
In-Reply-To: <c923da02-1429-4aa9-a044-5440232a47e0@kernel.org>
References: <20261106111645.786225-1-kalpan.jani@mpiricsoftware.com> <1a1ce1e9b07.f015539104390.2600884748737974966@mpiricsoftware.com> <08451824-13d5-4e92-adb6-2ebd6c5cf053@kernel.org> <1a1cf8c61dd.83068f79144867.7028423115634706290@mpiricsoftware.com> <c923da02-1429-4aa9-a044-5440232a47e0@kernel.org>
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

Thanks for the clarification.

I agree that introducing additional offsets or hashing the socket address just to hide the original values may add unnecessary complexity.

The second approach seems simpler. We can zero the relevant sequence-number fields when `mptcp_diag_fill_info()` is called from `mptcp_diag_get_info()` for Netlink diagnostics, while preserving the existing values for `getsockopt()`.

I will investigate this approach and prepare the patch as a replacement for v11, based on the correct mptcp_net-next tree.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "shardul.b"<shardul.b@mpiricsoftware.com>, "janak"<janak@mpiric.us>, "kalpanjani009"<kalpanjani009@gmail.com>
Date: Thu, 12 Nov 2026 17:55:31 +0530
Subject: Re: [RFC net-next v12] mptcp: normalize sequence numbers using socket address

 > Hi Kalpan,
 > 
 > On 12/11/2026 12:37, Kalpan Jani wrote:
 > > Hi Matt,
 > > 
 > > Thanks for reviewing and pointing this out.
 > > 
 > > Regarding the base commit, I understand the issue. My local patch was 
 > > tested against a tree that is not present in your current mptcp_net- next
 > > tree. I will check the correct base and prepare the patch as a replacement
 > > for v11 rather than stacking it on top of v11.
 > > 
 > > Regarding the offset, I understand your concern about exposing information
 > > derived from the MPTCP socket address.
 > > 
 > > One alternative could be to use independent random offsets for the local
 > > and remote sequence-number directions, generated once per MPTCP connection
 > > and stored in the MPTCP socket structure. This would avoid deriving
 > > the offsets from a kernel address.
 > > 
 > > However, this introduces additional state and initialization requirements.
 > 
 > Indeed... I think it would be better to avoid that "just to hide the
 > real values".
 > 
 > > We should also consider whether it preserves the expected semantics of
 > > the sequence numbers reported by MPTCP diagnostics.
 > > 
 > > Would retaining the existing `local_idsn` and `remote_idsn` values be 
 > > preferable, or do you think independent per-direction random offsets are
 > > worth exploring?
 > 
 > If we want to store the offsets, then better to use that, yes. But it
 > feels like we should do something simpler. At this point, I hesitate
 > with two options:
 > 
 > - when mptcp_diag_fill_info() is called from mptcp_diag_get_info()
 >   (Netlink, not getsockopt()), use a generated offset based on the msk
 >   address (or maybe there is something else we could use for the offset?
 >   We don't want to use the token for the same reasons).
 > 
 > - Or also only when called from  mptcp_diag_get_info(), return 0 for the
 >   sequence numbers.
 > 
 > Not sure the first option is worth it if it is costly "just for that".
 > So maybe just the simple second version?
 > 
 > > I would appreciate your thoughts before I proceed with the next revision.
 > 
 > Thank you for your patience.
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 



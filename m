Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794833030;
	b=DK+PsKJl5EhqFZk6lxHd5tm3OM+gnXlYDRa+TPgcglcNufQmC0B+gbqg0JjKCqWok8zk
	 Fd1O8KulAoqIKjKCKxSGIP2vUIhhgVxyE/d1nRe2R9GYEIzb3LAWHVITQshFTTlcFACwc
	 JAUrhhYuZ0MAJ9X8/eBrWeJka6jRvWfE7NqdTMI1XZj104T3ZCEgl1Gvnm5d8Pw9pPJwf
	 qkHHVMlrSs4I/uDkodOQ9/gK8wWYt2SB1Iz2rRzAclEWbazjB8HfE+nDk+29JIjbHshfW
	 gnRaFr2VAD4Ome9qQA6eu7FbkSO30XLk/urcsbpIg3JETQzx2oxo3hB60UmFxPYOMpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833030;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=2T+//HW1dxNu5xcpgkOgb2hN5Aw8+pCAHawKVeBm+K0=;
	b=k4pAa/MxRVGWrytP1w2ad44Ifsobx4BV981S64AidVYNiGwxXLB5b/2dm414HIVDF8cY
	 KYNdCMKPHd+u6PvWXem9S3G52Ct5d0cGp85hALxpA1kX2Q5cNac+xFuv+1OFu0hj8O3pT
	 WPyXj8AbqKvqDal03DBeduwPN8h1n9PbiTQ2mcuRXgD0hO8Bu55vslOqm+5FuZX9rvah3
	 2Mf93pYCqmHQQrrCRJuAw0A1+jVwdlqfmkufoNJX/wCFwOLpjJlUBqoEPVSc0S2hYocLD
	 lagqlYwi1KbXLREhQOhdZ2epAvRMK86bY7m1wsLMptThM6K0HwzXMTsnsSFjxqvjnhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B1606A32A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 12:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 831B1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1794833027; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WJLjqHQkmUX8MPUbLI32ofcq9agYfzKZAUK/pbkPAuSqCwJjg+JpfGHL+D9PZCB5vGeztm1mZWadOqO7b1j1bEdNX8hsfppY25Pz+0mSJu3xfeSuBlJLwiAqmYtMY2JK9t8Hgj40DFole+qLTm3NjyMciYUKBTxvKeMBe7w+lsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794833027; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2T+//HW1dxNu5xcpgkOgb2hN5Aw8+pCAHawKVeBm+K0=; 
	b=G0gZPmpBj/i3+We3gM0lvdr4r7YxdHQVwrymDqFiwmO33X9RJ9tIVcL3QUd45veW5lU3Fiuj/LVweqKPhZzU32KCQT0wY1xhee2HzEJSLwP99eVZ5jKzm3niYTl4NzoDoamPB1GWpnLqKeq/pc1qpo7DeQiasCiP5sz+ev4CWPA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=SSFka8zCQOB9I1RuE4WmEPRn7db9pJFjcoz+MMUCrV+UpTYQ+NJ0yyQcl6S5mNixpFHLk2FIRjtbMWX52JNnTZNnZxjNgYXhjkGmvrgvIEd5YZEure25K/5Bk02+k77xK2r/dyvdW2lZGIXS84BYzK8Pgm9UfkN5oaNqI6JpwEo=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=2T+//HW1dxNu5xcpgkOgb2hN5Aw8+pCAHawKVeBm+K0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1794833023252969.9515448286629; Mon, 16 Nov 2026 04:43:43 -0800 (PST)
Date: Mon, 16 Nov 2026 18:13:43 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a1e4628081.655ae76e420453.2576402304811820615@mpiricsoftware.com>
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

For the latest v13, I have removed the address-based sequence-number normalization and zeroed `mptcpi_write_seq`, `mptcpi_snd_una`, and `mptcpi_rcv_nxt` directly in the MPTCP Netlink diagnostic callback.

This keeps the changes limited to the diagnostic path and leaves getsockopt() reporting unchanged.

Currently, these fields are zeroed for all users, including those with CAP_NET_ADMIN.

Would you prefer this behavior for all users, or should we hide these fields only from users without CAP_NET_ADMIN?

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



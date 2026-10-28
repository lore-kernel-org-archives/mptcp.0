Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793183646;
	b=elVZaBRoz3LwpewE/TqNdU+YFEZ22QHIpxpesfZc7aMMhTWTNswaSolu2/dBFUazDFI7
	 /uSdyE99fE0oywooHLBNV3jT5x7dnjsMZz0Pge2AtRaBFTnGHwcp8T7WT2VBlyEGMvd7E
	 krSCo+qiQb+qDbtHl03tLg9PkSZ/uAEz5tx2s9XTFAZ9Bb7Gmil5687cXpZmTwjlWp4GE
	 kuyehEE9VeuPkYAjE0EpKnU4gNzfZ1gsYd3spizUtCZZYia+n+xEs+rCVTl2y40OzMFiw
	 DKrChp0TW1sgQORfPhHosuFL1PjDrQ0k724a9KYAB3UIqBDiL9I9xsOj8eIkxdvyB6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183646;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=/Og4AURVJIDpRlJNkntpYElZT4PM9YKiu1q6oBJt3g0=;
	b=fzud6BAsRiDYdMWBcrIG9aFlc6LwSILikOOuZyIOpMQHH/bcuq+zUHNMelk1Opy0EEHN
	 z67lSgtDPTeA5OF5867Anz8HXSjDpi3fwoGuCnXbu734ElwOLIhQmvHvbTe3semI/KbYg
	 iBdogU4H3KoZgVSnSp9g03ePz385rLV2gKYwDaaFZwOf0CwHLXhVteBHAeP1vHsoRh4XG
	 ahrWZCEoBxJbsBU5i14zFt3AjOru2uSuWRkLvIQFgiTNRWnoduAIY1pypYLyrE+0q2hCq
	 VvjsP/AAEI6jtwTx6FVLqzytdw9Rw61JAnjGYoXYvK9bCAM1CS7sygAKJ5tR8AXt3ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39613606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 10:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39613606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793183640; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PlEnP1lTzFXbDB4g0Ng2tc9b0+ZA/JlY4cZaij1eScK21pmj7jq38MCDomeW84m3dkolq4QuFR+15e08p/07mvIhDqRwc+1ZkmZ+JErnrJv904zlRGMyNIcCOkPm063PWVMQmzqiYQI4dK8LgyJXneycWNgDuZAUbQqKSgBNROw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793183640; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/Og4AURVJIDpRlJNkntpYElZT4PM9YKiu1q6oBJt3g0=; 
	b=DC9cOcS6Z5WLqfkW4SRU3oh/sZa4X5Iai1v99owtiOiSl8AOpx7IMqHPJXoPEgeYzGpqjHBUh8ieeQXM6zYDSwJtOCyGhnUOmDL0r4/9HxvlULG0eYzzvjQXRY2ILEkoTO7NESezV1Prlrji5JfQ79T2ftfmyL87nOXBl2BZnaw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793183640;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/Og4AURVJIDpRlJNkntpYElZT4PM9YKiu1q6oBJt3g0=;
	b=nr/cNfcP8qR90eLX/xBURPRtaHvP3Ix+ruva5GMSy/IkrVDOM6SBpMadzsDy2w8P
	Ks/GC4hBiuUtIzQvKhiRkiirhsc+s5c/QQWE+YD/2Y+OuMCKRvu6IU6BNbdMkLwdtjq
	oU3cxk6yUx99SJUL5Cbs94fziHHFNOr/yPMrXb6U=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1793183636521569.4170173550001; Wed, 28 Oct 2026 03:33:56 -0700 (PDT)
Date: Wed, 28 Oct 2026 16:03:56 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>
Message-ID: <1a18212dbaf.7594e0f1624805.5831653841901931656@mpiricsoftware.com>
In-Reply-To: <495a89c5-40ca-4758-8366-6c4c28e28112@kernel.org>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com> <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com> <ad0f8a94-09b8-46d4-b807-94f1f52f1d1d@kernel.org> <1a17d565bd7.51ae4f93484769.4801857719496061627@mpiricsoftware.com> <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org> <495a89c5-40ca-4758-8366-6c4c28e28112@kernel.org>
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in
 mptcp_info
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

No, I haven't tried the msk-address offset approach yet.

I sent RFC v11 with the alternative approach of hiding the sequence fields from users without CAP_NET_ADMIN, based on your previous message. I did not mean to imply that the pointer-offset approach had been tried and found not to work.

The two patches applied and built successfully against my local mptcp/net-next tree, and both passed checkpatch. However, I haven't done a runtime test of the access restriction or tested the pointer-offset approach.

I'll look into the pointer-offset option before deciding whether another revision is needed. Since v11 has already been sent, I'll wait for your feedback before posting any further changes.

I also understand your point about email threading. I sent v11 as a reply to the existing thread, but I'll start a new thread for future patch series.

Sorry for the confusion.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "martineau"<martineau@kernel.org>, "pabeni"<pabeni@redhat.com>
Date: Wed, 28 Oct 2026 15:13:05 +0530
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in mptcp_info

 > Hi Kalpan,
 > 
 > On 27/10/2026 14:42, Matthieu Baerts wrote:
 > > Hi Kalpan,
 > > 
 > > Thank you for your reply.
 > > 
 > > On 27/10/2026 13:29, Kalpan Jani wrote:
 > >> Hi Matt,
 > >>
 > >> I investigated the existing byte counters and the diagnostic
 > >> capability path.
 > >>
 > >> The existing byte counters are not direct replacements for the
 > >> normalized sequence fields:
 > >>
 > >> - write_seq advances when application data is queued and when
 > >> DATA_FIN is added. bytes_sent tracks send progress, and the
 > >> retransmission path can update snd_nxt directly without updating
 > >> bytes_sent. - snd_una is assigned directly during connection setup,
 > >> outside __mptcp_snd_una_update(). Therefore, bytes_acked cannot be
 > >> assumed to reproduce snd_una - local_idsn. - ack_seq advances when
 > >> processing DATA_FIN, whereas bytes_received counts payload bytes.
 > >> Their initial values also differ.
 > > 
 > > OK, let's not use the bytes counters then.
 > > 
 > >> Regarding the capability check, the normal MPTCP diagnostic dump
 > >> paths have access to the original request skb and can check
 > >> netlink_net_capable(cb->skb, CAP_NET_ADMIN).
 > > 
 > > Good!
 > > 
 > >> However, inet_diag_handler_get_info() is also called for socket-
 > >> destruction notifications. In that path,
 > >> sock_diag_broadcast_destroy_work() creates a new skb and invokes the
 > >> callback without an original diagnostic request. Therefore, the
 > >> requester's capability cannot be recovered from that skb. Passing
 > >> false in this notification path appears to be the appropriate
 > >> conservative behavior.
 > > 
 > > OK to pass false in this case.
 > > 
 > >> Based on this investigation, I will keep the capability/privacy
 > >> change separate from sequence normalization. I will also address the
 > >> stale remote_idsn after disconnect and the inconsistent sequence
 > >> snapshot reported by Sashiko before sending another normalization
 > >> revision.
 > > 
 > > Just to be sure it is clear: the main goal here is not to show the seq
 > > counters to everybody from the same netns. This can be done either by
 > > "normalising" them -- i.e. starting from 0 -- or by not presenting them
 > > to some users.
 > > 
 > > Just thinking about that: for the normalisation, we can also just
 > > add/remove an offset the userspace cannot predict and different per
 > > connection. In fact, why not using the address of the msk pointer? I
 > > guess that should prevent the different issues reported by Sashiko, no?
 > 
 > Was this workaround using the msk address not working?
 > 
 > BTW, please next time don't send new series as a reply to an email,
 > start a new email thread instead.
 > 
 > > (In case of "other" existing issues, please split them and move them in
 > > a dedicated patch not to mix the fix and the main patch here.)
 > > 
 > > If the "normalisation" is not possible, better not displaying them to
 > > non cap-admin users. But we don't need both.
 > > 
 > > Cheers,
 > > Matt
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 



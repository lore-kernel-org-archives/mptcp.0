Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793104187;
	b=JUbFNU+0HeSAo6VgSM21zH4iKoGkhsXSOO6ZGtvERVD5ZM13/zS3KU4awFlpgQu//Kh1
	 rNBSj+tpChQQ/fqEw19ENXGYs1OpIQj82vQj+ARKsYdKnzy6Htc4xBawRUdbz7OPHcQFw
	 Thfh6rFEQgYs+xp6FTEo9arN4w+0vj4cewbd32FfjLdnZhKObHRhB8+9XUOp295CcruQ9
	 vRu4KtjfBwBllapmLgcQm/+fmu1jIVsZBoLeBA+sesiJF6V8bhmGwcVz0Yz5Q4ztzDCuD
	 ywm5VX+CH4ayWQT6zYQD5dJv6Rpu7olNSQJ7CdTGlnti6VhXl06pwGOkBxHO2Im+aVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104187;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=uT4EtiobDsOMDgefC4s/QjydkeRdEFOrVedhzInslsE=;
	b=pUtkOGiNdFjNn5yg7OsLU6kowaRxk1zEMxUKhsNKLcmDbGjqbAQMAnRADjCr+2t9PEpr
	 pG2IZFC7mLGCqXSh47BAIXiUz9MRU3JqXWURyCYb5T01pL/hjXjStYiQuSaGZMeisAHtM
	 Zd6SaZbWCqghMwnBGZMtkKLQVXHCqsLQPKL4E9WaN2a5FrcUAN8F8AxANrxA4vMxZj10C
	 YKgYUtfxaLVJDJT+Vwp8h4fKXUrZCFe4nVjvqCp1THjnU8WV1pldZEhZV9f3f2PQWpZHb
	 5ijbahCWAHBU5ZfNig1zks9O58za8kNYYmu3m9qtJwbBPSYDgAvoS/vJUxFdylW4xnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BD606CB2C
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 12:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C4BD606CB2C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793104178; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G9VxeU6LSWbVejR/C9V3oHdWQpufaQVGU0+TcIRVXdF87s+G+Im6UG0EJZwWVrq98Q9vgwo6kYBP8bXw5wmaNYcdR29l3F2jnQDvbQZIEHlM7lJxry/jU+Pr0HeyZhPjLGoa4qEVOAE9kI6Hd8Ct8+qatZguc7fO/HKJKjo4GbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793104178; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uT4EtiobDsOMDgefC4s/QjydkeRdEFOrVedhzInslsE=; 
	b=DvkbQs0b4NHlU5C/eJQXA8N5zEgrLP0OBGFbCjD2XNvXjJa1WpYEV+5dV/1ftanTqptAiYQg2eWB0LTcdlUDUKI5RQo8aBTxYrnqLNAfrC/XVOkFzvzrR0Lvf99LtOYbokmbKcT6CZHvxjAkd+Y7vPPPGh3tNXTv2Z/PkLxFQpI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793104178;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uT4EtiobDsOMDgefC4s/QjydkeRdEFOrVedhzInslsE=;
	b=ho9Smqbk92EXjoj71j5RICHgD5uA5T4loZdHz0LXedXdXs44UkEmyfa9nZ2IvhEI
	l9hcGo6mmtdPj5ImqHyuQL/KsDmGrdLNs1LXf2bvEQEp7KK+O3HbOjR/g2B3HtjLNcw
	ORGGa1C+tp3hPllijoMjBaY0SI1uXIXN2VA1wqts=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1793104174061795.9636357823046; Tue, 27 Oct 2026 05:29:34 -0700 (PDT)
Date: Tue, 27 Oct 2026 17:59:34 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>
Message-ID: <1a17d565bd7.51ae4f93484769.4801857719496061627@mpiricsoftware.com>
In-Reply-To: <ad0f8a94-09b8-46d4-b807-94f1f52f1d1d@kernel.org>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com> <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com> <ad0f8a94-09b8-46d4-b807-94f1f52f1d1d@kernel.org>
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
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

I investigated the existing byte counters and the diagnostic capability pat=
h.

The existing byte counters are not direct replacements for the normalized s=
equence fields:

- write_seq advances when application data is queued and when DATA_FIN is a=
dded. bytes_sent tracks send progress, and the retransmission path can upda=
te snd_nxt directly without updating bytes_sent.
- snd_una is assigned directly during connection setup, outside __mptcp_snd=
_una_update(). Therefore, bytes_acked cannot be assumed to reproduce snd_un=
a - local_idsn.
- ack_seq advances when processing DATA_FIN, whereas bytes_received counts =
payload bytes. Their initial values also differ.

Regarding the capability check, the normal MPTCP diagnostic dump paths have=
 access to the original request skb and can check netlink_net_capable(cb->s=
kb, CAP_NET_ADMIN).

However, inet_diag_handler_get_info() is also called for socket-destruction=
 notifications. In that path, sock_diag_broadcast_destroy_work() creates a =
new skb and invokes the callback without an original diagnostic request. Th=
erefore, the requester's capability cannot be recovered from that skb. Pass=
ing false in this notification path appears to be the appropriate conservat=
ive behavior.

Based on this investigation, I will keep the capability/privacy change sepa=
rate from sequence normalization. I will also address the stale remote_idsn=
 after disconnect and the inconsistent sequence snapshot reported by Sashik=
o before sending another normalization revision.

The existing counters are not direct substitutes for the sequence fields, a=
lthough dedicated accounting remains a possible option if needed.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, <mptcp@lists.linux.dev>
Cc: <martineau@kernel.org>, <pabeni@redhat.com>
Date: Tue, 27 Oct 2026 16:15:13 +0530
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in mp=
tcp_info

 > Hi Kalpan,
 >=20
 > Thank you for your reply.
 >=20
 > On 27/10/2026 10:54, Kalpan Jani wrote:
 > > Hi Matt,
 > >=20
 > > Thanks for reviewing the new version and for the suggestions.
 > >=20
 > > I understand that v10 mixes two different approaches: normalizing the
 > > sequence values and hiding them from unprivileged diagnostic
 > > requests. I will separate these concerns rather than keep them
 > > bundled together.
 > >=20
 > > I will first check whether the requester's CAP_NET_ADMIN status can
 > > be obtained reliably from the existing skb in
 > > inet_diag_handler_get_info(), so that we can avoid changing the
 > > idiag_get_info callback interface if possible. If that is not
 > > feasible, I will keep the generic callback change separate from the
 > > MPTCP-specific diagnostic change.
 > >=20
 > > For MPTCP_SUBFLOW_ATTR_MAP_SEQ, I understand that the value should be
 > > zero for callers without CAP_NET_ADMIN. I will apply the same access-
 > > control policy consistently to the relevant MPTCP diagnostic fields.
 > >=20
 > > I will also investigate whether the existing byte counters, such as
 > > bytes sent, received, and acknowledged, can provide the information
 > > needed for issue #445 without exposing the sequence counters. I will
 > > keep any required sequence-baseline fixes, including the two issues
 > > reported by Sashiko, separate from the diagnostic access-control
 > > change.
 >=20
 > Just to be sure it is clear:
 >=20
 > - If it is possible to use the bytes counters to provide the normalised
 >   seq counters, let's use them. If not, please say why before sending a
 >   new version, maybe we could add a similar counter instead of relying
 >   on the initial one.
 >=20
 > - If that's not possible, set 0 for if no CAP_NET_ADMIN by looking at
 >   the skb (minimal changes only on MPTCP side).
 >=20
 > - If that's not possible, add the net_admin parameter, and try to avoid
 >   setting "false" in inet_diag_handler_get_info =E2=86=92 maybe we can c=
heck the
 >   capability linked to this skb? =E2=86=92 to be tested of course
 >=20
 > > I will update the patch series after checking these points and
 > > validating the changes.
 >=20
 > Thank you for your patience!
 >=20
 > Also, please reply to the right message with quote to add context,
 > otherwise it is hard to follow when switching between many series.
 >=20
 >   https://subspace.kernel.org/etiquette.html
 >=20
 >   https://docs.kernel.org/process/email-clients.html
 >=20
 > Cheers,
 > Matt
 > --=20
 > Sponsored by the NGI0 Core fund.
 >=20
 >=20



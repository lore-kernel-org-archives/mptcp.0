Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B81B1419
	for <mptcp@lists.linux.dev>; Thu,  4 Jul 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107551; cv=none; b=EITbpskMUzuDZyF0gqSrdUhjdrKpcfxiwdZ3KrDgs/jUrKBGfF+ZTihPsjBmNenBw+s/1+0MoApVLwnFl8FqprKQNQ5l0UXRJ66i0v1SaO450PSL+/8LN0yKB+V8tiSjl42uC7MrQzYC+xOjiKItENp2gz+pUd0tKkPolju6kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107551; c=relaxed/simple;
	bh=hgU+dcJ1YIfVbqKHlUm6ofEehVZTd28RbtgWFdiDCEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3R5Wepgu41CctO/8ISstLIk6G6/+p7Jvg94CQfhDHlJ7noKgI0iR9THaPYLTBUCHZtWOQrgh9k52vqJchVMOOZW9fGx2eKIe+A7qjNAW+sJ7moJzuVzk1kWwmmj8ZGTHY1z3m6Dt3f19Djn5RgnYhg5dFiRFV2yQrKWIRj0WQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTcIjUAR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTcIjUAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720107549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cmZpghoLIx7Ba6zGuTidAFHnLj4FA1S4ou+Yt6LVWtg=;
	b=YTcIjUARC3LB0S8tYh8KG00aBuBvq8vsQRQYXCC5vrWPL1/c8sAkDjiAogeAwd0TYaGA47
	Zf3naQb7lvF3WT6ZvBEwa7G/aYbXFF6Crr3BmAD+Q7jzJs9KpALczNKTIdC7bp6yjemtb+
	ms0AMNaCXwMwA5fId4PLPYR92dOMSc0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-s58NUlepM1a-pu8fOm_1aQ-1; Thu, 04 Jul 2024 11:39:07 -0400
X-MC-Unique: s58NUlepM1a-pu8fOm_1aQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367a19f9fd7so69170f8f.3
        for <mptcp@lists.linux.dev>; Thu, 04 Jul 2024 08:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720107546; x=1720712346;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmZpghoLIx7Ba6zGuTidAFHnLj4FA1S4ou+Yt6LVWtg=;
        b=n8uZza+oM1qB8v5bm5FA4ZARrHeEwcuXejUVuz6LVMS9tYqMB8WgVuvBsMR7hh8j9n
         vdkX0Gh0aXxYZlt9QHypDk8O01am51FpWPr1Bc4EOtYqtiXEH/lM2Hlu0QWD4uyoB6pO
         DmgruLdcoNK2ntb/vRkX1exEebIMu6D4XA1g5KLCyX9p0eboaM9aLC4qEV2Pw3BfxRkE
         5aEewUaGH7gFXHy7eetuKFSqdVFfuPjW+oORJVF+jCG3RFMh/S/ksn544XcoT8dsNr8E
         0zvHVa5QfHZo2XA86p/ppxv9csnqT0aKtcyiNz4DgQbUa3Jnzp1jhv2Ekc1+yJ/8X7no
         uENw==
X-Gm-Message-State: AOJu0YwLpmQeFbRgqvmHjXha+L6PHKNCgiA6R1WcCSRkUYptuQaG2pjH
	H84TJT3Okg1RUWhcnls1dgkVTxuMMPpmDfwV7tzf2nEWIKa++KAa88pOEaoWxBNM0znSsEQQNlg
	AfRR5p3FKJ6PaQa5Ed/qGYLFkZQphoPlCufje1TgEzi/diarPq9V9
X-Received: by 2002:a05:600c:510f:b0:425:6c50:865e with SMTP id 5b1f17b1804b1-4264a431d0fmr15921645e9.2.1720107546420;
        Thu, 04 Jul 2024 08:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3WimiLOlqvFUoo6g2zDHJCN0raDHQk3+q1SZmDfDs1ARojxif+ezhTrodE7YQk7bR2IO3OQ==
X-Received: by 2002:a05:600c:510f:b0:425:6c50:865e with SMTP id 5b1f17b1804b1-4264a431d0fmr15921515e9.2.1720107545967;
        Thu, 04 Jul 2024 08:39:05 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a251ef5sm28602065e9.36.2024.07.04.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:39:05 -0700 (PDT)
Message-ID: <236ffd81d640eec8614fc47caf5b8500178fa44b.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/3] mptcp: fix announced address accounting
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Thu, 04 Jul 2024 17:39:04 +0200
In-Reply-To: <82e70747-2a6e-4a40-b5f7-573b23317780@kernel.org>
References: <cover.1719589916.git.pabeni@redhat.com>
	 <4a8ac95282ec2b551a64134f24b2e2fd7d82973c.1719589916.git.pabeni@redhat.com>
	 <f5abcf0d-1ca3-5601-3159-2d553f3591c4@kernel.org>
	 <82e70747-2a6e-4a40-b5f7-573b23317780@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-07-02 at 10:51 +0200, Matthieu Baerts wrote:
> Hi Paolo, Mat,
>=20
> On 01/07/2024 20:08, Mat Martineau wrote:
> > On Fri, 28 Jun 2024, Paolo Abeni wrote:
> >=20
> > > Currently the per connection announced address counter is never
> > > decreased. As a consequence, after connection establishment, if
> > > the NL PM deletes an endpoint and adds a new/different one, no
> > > additional subflow is created for the new endpoint even if the
> > > current limits allow that.
> > >=20
> > > Address the issue properly updating the signaled address counter
> > > every time one of such address is removed.
>=20
> Thank you for having looked at that!
>=20
> > > Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > slightly unrelated: is unclear to me why mptcp_pm_remove_addrs() does
> > > things slightly differently from mptcp_pm_remove_addrs_and_subflows()=
,
> > > with the latter IMHO doing the right thing (TM)
> >=20
> > Hi Paolo -
> >=20
> > I don't remember why mptcp_pm_remove_addrs() has the extra code to send
> > the RM_ADDR for addresses that are in the conn_list but not the
> > anno_list. Maybe to allow a way to sent RM_ADDR as a "request for the
> > peer to initiate a disconnect" even on implicitly added address IDs
> > (from outgoing subflow connections instead of ADD_ADDRs)?
>=20
> mptcp_pm_remove_addrs() is only used by the userspace PM, it should
> probably be moved to pm_userspace.c in fact (but it uses helpers from
> pm_netlink.c, I guess that's why it is there). My understanding is that
> it also checks the local subflows list because the userspace can ask to
> send a remove ADDR for addresses that have been "implicitly" announced
> via the MPJoin as well.
>=20
> Maybe the modification in mptcp_pm_remove_addrs() should be in a
> different commit? With a different Fixes tag then:
>=20
>   Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
>=20
> >=20
> > > ---
> > > net/mptcp/pm_netlink.c | 27 +++++++++++++++++++--------
> > > 1 file changed, 19 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index ea9e5817b9e9..624f9ea66aea 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -1401,6 +1401,7 @@ static bool mptcp_pm_remove_anno_addr(struct
> > > mptcp_sock *msk,
> > > =C2=A0=C2=A0=C2=A0=C2=A0ret =3D remove_anno_list_by_saddr(msk, addr);
> > > =C2=A0=C2=A0=C2=A0=C2=A0if (ret || force) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_bh(&msk->pm.lock=
);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msk->pm.add_addr_signaled=
--;
> >=20
> > Looks like this only be decremented if ret is true, since that indicate=
s
> > a list element was removed and add_addr_signaled is supposed (?) to
> > track the length of the anno_list.
>=20
> Good point.
>=20
> Should we not also set the corresponding bit in:
>=20
>   msk->pm.id_avail_signals_bitmap
>=20
> Linked to my series:
>=20
>=20
> https://lore.kernel.org/mptcp/20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@k=
ernel.org/T/
>=20
> Otherwise, we will not be able to re-use the same ID, no?

This is for net, your series is rightfully for net-next, I guess you
should do the id_avail_signals_bitmap accounting only on the latter.

Thanks,

Paolo


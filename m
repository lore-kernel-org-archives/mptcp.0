Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBB10E9
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565408; cv=none; b=SsN5cZOe5UUsxJykS1gvzjj5N/R80FizmtNzfp5aqeHf4gZ3ycz35xrU+y3sH/QUkFsKTKsRA73zBqnfPFVUCYidsazSA8IICSO9K78+Xln+TDXk0cP6aZSF0UGCN91h8ZMXEgziSw6R2k32O30TYj3k8wi1BtEU60nJt92umeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565408; c=relaxed/simple;
	bh=erRkgz1xAQ2RIYBUpBU66OQw9Y5wtvQslRxUa1uqZDc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CRvEhLGF7cvI7ukIChwM4BU5wazaYEsNXaP78agEvKoqdb/MW2CfyuhOxBKgA+bCQhid9CP2Vi1we/Ud9dxtFE9QRiO3Ujz217OAS0GmYDHKI/3+1ZYbsiM+HnoBzQvRiGBgtZYs4YIqHHsH5mp7BZZW5iTa+6GyhVbGliRecCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcdEg3nH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcdEg3nH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4390CC433C7;
	Mon,  8 Apr 2024 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712565408;
	bh=erRkgz1xAQ2RIYBUpBU66OQw9Y5wtvQslRxUa1uqZDc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=CcdEg3nHXGM5aTACD4DVqiTCWERUJhrw4XQQQcPHcqtefJ131zZwM0982chUbrZY6
	 rCOa5psmpL1RKU9d+V4Rit4TZJltq+gq31YFbGDV/Ul4m1kdydpTWkrRsHJ6vhe8dF
	 8cShfQAB7Q9ctvlf33tHwK4colsnAwY/7hf40oIoxqXFTUa3YikzZp2bn28qh4SiVk
	 rIPTjNy5Qc/OFVsBkUSq6PRxF/vkMA9GOAGJvBauScT9VywPVgffVFDgDDnUWG9BQu
	 VMopQnT9G+ZLvVE2Q9e8wKrNNMLDRTvrG4rgeEorG9q2iGmcL8qSnsu0PjlYyoognH
	 a2lOZYst8EKIQ==
Message-ID: <cafa14c36ba948be4d635b6dd45278fb1aa15cb4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2] Squash to "mptcp: add last time fields in
 mptcp_info"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 08 Apr 2024 16:36:43 +0800
In-Reply-To: <ce361a99-6f83-48f7-bc0e-cefa78d9ce6f@kernel.org>
References: 
	<7930751788d3bc8155898d4a22bdd6efca8cfde0.1712486293.git.tanggeliang@kylinos.cn>
	 <ce361a99-6f83-48f7-bc0e-cefa78d9ce6f@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-04-08 at 10:23 +0200, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 07/04/2024 12:38, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > Please append the following lines into the commit log:
> >=20
> > '''
> > Since msk->last_ack_recv needs to be protected by
> > mptcp_data_lock/unlock,
> > and lock_sock_fast can sleep and be quite slow, move the entire
> > mptcp_data_lock/unlock block after the lock/unlock_sock_fast block.
> > Then mptcpi_last_data_sent and mptcpi_last_data_recv are set in
> > lock/unlock_sock_fast block, while mptcpi_last_ack_recv is set in
> > mptcp_data_lock/unlock block.
> > '''
> >=20
> > v2:
> > =C2=A0- move the entire mptcp_data_lock()/mptcp_data_unlock() block
> > after
> > the lock_sock_fast()/unlock_sock_fast() block.
> > =C2=A0- can't move it inside lock_sock_fast()/unlock_sock_fast() block,
> > this
> > =C2=A0=C2=A0 causes a deadlock.
>=20
> Thank you for this v2, it looks good to me!
>=20
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0net/mptcp/sockopt.c | 16 +++++++++-------
> > =C2=A01 file changed, 9 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index 2ec2fdf9f4af..40b262b2c24a 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -896,9 +896,9 @@ static int
> > mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level,
> > int
> > =C2=A0void mptcp_diag_fill_info(struct mptcp_sock *msk, struct
> > mptcp_info *info)
> > =C2=A0{
> > =C2=A0	struct sock *sk =3D (struct sock *)msk;
> > -	u32 now =3D tcp_jiffies32;
> > =C2=A0	u32 flags =3D 0;
> > =C2=A0	bool slow;
> > +	u32 now;
> > =C2=A0
> > =C2=A0	memset(info, 0, sizeof(*info));
> > =C2=A0
> > @@ -927,12 +927,6 @@ void mptcp_diag_fill_info(struct mptcp_sock
> > *msk, struct mptcp_info *info)
> > =C2=A0	if (READ_ONCE(msk->can_ack))
> > =C2=A0		flags |=3D MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
> > =C2=A0	info->mptcpi_flags =3D flags;
> > -	mptcp_data_lock(sk);
> > -	info->mptcpi_snd_una =3D msk->snd_una;
> > -	info->mptcpi_rcv_nxt =3D msk->ack_seq;
> > -	info->mptcpi_bytes_acked =3D msk->bytes_acked;
> > -	info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk-
> > >last_ack_recv);
> > -	mptcp_data_unlock(sk);
> > =C2=A0
> > =C2=A0	slow =3D lock_sock_fast(sk);
> > =C2=A0	info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
> > @@ -944,9 +938,17 @@ void mptcp_diag_fill_info(struct mptcp_sock
> > *msk, struct mptcp_info *info)
> > =C2=A0	info->mptcpi_bytes_retrans =3D msk->bytes_retrans;
> > =C2=A0	info->mptcpi_subflows_total =3D info->mptcpi_subflows +
> > =C2=A0		__mptcp_has_initial_subflow(msk);
> > +	now =3D tcp_jiffies32;
> > =C2=A0	info->mptcpi_last_data_sent =3D jiffies_to_msecs(now - msk-
> > >last_data_sent);
> > =C2=A0	info->mptcpi_last_data_recv =3D jiffies_to_msecs(now - msk-
> > >last_data_recv);
> > =C2=A0	unlock_sock_fast(sk, slow);
> > +
> > +	mptcp_data_lock(sk);
> > +	info->mptcpi_snd_una =3D msk->snd_una;
> > +	info->mptcpi_rcv_nxt =3D msk->ack_seq;
> > +	info->mptcpi_bytes_acked =3D msk->bytes_acked;
> > +	info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk-
> > >last_ack_recv);
>=20
> Detail: I suggest moving this line just after 'mptcp_data_lock(sk)',
> just to have all the "last time" counters next to each others.
>=20
> I can do that when applying the patch.

Thanks Matt. I agree, it's much better.

-Geliang

>=20
> > +	mptcp_data_unlock(sk);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
> > =C2=A0
>=20
> Cheers,
> Matt


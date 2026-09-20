Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D22EC083
	for <mptcp@lists.linux.dev>; Sun, 20 Sep 2026 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890537; cv=none; b=dpXl0i9u959c38nTvSL78+DTN6jIta5Jv0UIW3LKyLMFY3lPDfQ3d/xAlxjoTcvvpgNX5dW1K/Ycku3V0YtrbauiwBM+/D2FbAZTQCaTAYR2KB/dSghnTR8pmetJLGXth8RZCbXnE+RgR9b11WkQLI4LEhtOLFqnGEp+/QFpg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890537; c=relaxed/simple;
	bh=ubVvRhg0JCNOcZz5rntqL3/SEv0JF5s3VbBHBvQlONM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZQ5fX5WfeBLFn7Q4H4KFCEzKxRYpejoB+JRN0S+9gb0Aeqe45XzvJkkpu76q/yv4tq1stVb025sGSxIGmNhzIYx6gew+hQ1rLl1FbgaTOJGsp8dUaeQaJlezISGtdb7aBKcqJMWPl8zcy1RE+JkBguQp9JNeeqxIc1q4MpXgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogkk3tWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogkk3tWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DFF1F000FF;
	Sun, 20 Sep 2026 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789890536;
	bh=jpQ3ZEUuIzxjfXTE7m2GU0WZpWjWIIA6WPNFtU7ViLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ogkk3tWZ8/K9j7VDzSSQb2ST8ctc//8Db5A+cLfMsfuCyLsfs0xnqoehZO5S8OBbX
	 ZPgE2Zlou5bc9dJKyasO/3DPBfdMqmJ/crfDxKTZfVI0a54lVFFhgGiZg2hBFMH+zG
	 ZWD4qJLObVVb7atP3d26doEeaTj5AsnrlRyjXRH5ry3ZOgx67/y6cYeGdWR/NlUlSP
	 qkRo8ZKNI6MoHyLku5HQLxZNLQkqdgaMrRXHZl/VQCepI/yAVdJ60cA2hx/Piocf/Y
	 UEg8jusyRiXSgILJk8skzGK84bWRDR8gcAxlQmjZjHBMx/6Pz9YO1ROzHrNyhY1qpp
	 pRwIjRqxvnqKQ==
From: sashiko-bot@kernel.org
Subject: Re: Patch "mptcp: annotate data-races around
 subflow->fully_established" has been added to the 6.12-stable tree
Reply-To: sashiko-reviews@lists.linux.dev
To: gregkh@linuxfoundation.org
Cc: mptcp@lists.linux.dev
In-Reply-To: <2026092037-islamic-default-0aca@gregkh>
References: <2026092037-islamic-default-0aca@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 07:48:55 +0000
Message-Id: <20260920074855.D7DFF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mptcp: build failure due to READ_ONCE() on bit-field
--

commit 2cede4d0675228e6db5b209f56d2a298cf7cb2e9
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Subject: Patch "mptcp: annotate data-races around subflow->fully_establishe=
d" has been added to the 6.12-stable tree

This commit annotates data races around the fully_established flag in the
mptcp subflow context. It aims to convert the flag from a bit-field to a
boolean type to safely use READ_ONCE() and WRITE_ONCE().

Link: https://patch.msgid.link/20241021-net-next-mptcp-misc-6-13-v1-2-1ef02=
746504a@kernel.org

>     Additionally, we make a crucial change: convert the subflow's
>     'fully_established' from 'bit_field' to 'bool' type. This is
>     necessary because methods for avoiding data races don't work well
>     with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
>     the size of the variable being accessed, which is not supported in
>     'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.

[Severity: Low]
Was the hunk converting this field to a boolean dropped during the backport?
It appears fully_established is still defined as a bit-field in
struct mptcp_subflow_context.

Additionally, the write side update was missed in the backport:

net/mptcp/subflow.c:__mptcp_subflow_fully_established() {
    ...
	subflow->fully_established =3D 1;
    ...
}

This lacks the WRITE_ONCE() annotation and continues to perform an unsafe
read-modify-write on the shared bit-field word.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 370c3836b7712..1603b3702e220 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -461,7 +461,7 @@ static bool mptcp_established_options_mp(struct sock =
*sk, struct sk_buff *skb,
>  		return false;
> =20
>  	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown tak=
e precedence */
> -	if (subflow->fully_established || snd_data_fin_enable ||
> +	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||

[Severity: Low]
Does this trigger a compiler error? Since the struct modification was missed
and fully_established remains a bit-field, applying READ_ONCE() here attemp=
ts
to take the address of a bit-field, which is syntactically invalid in C.

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 568a72702b080..e9dba0708ee70 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -532,7 +532,7 @@ struct mptcp_subflow_context {
>  		is_mptfo : 1,	    /* subflow is doing TFO */
>  		close_event_done : 1,       /* has done the post-closed part */
>  		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
> -		__unused : 8;
> +		__unused : 9;

[Severity: Low]
Does this increase the total bit-field group to 33 bits, causing a boundary
overflow?=20

Since fully_established wasn't actually removed from the bit-field group in
this backport, incrementing the unused bits to 9 pushes the total beyond a
32-bit word size.

>  	bool	data_avail;
>  	bool	scheduled;
>  	bool	pm_listener;	    /* a listener managed by the kernel PM? */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026092037-islamic-=
default-0aca@gregkh?part=3D1

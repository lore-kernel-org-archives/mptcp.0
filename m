Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3E268C40
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475904; cv=none; b=qac7ZVMJ77qV+ScbrinCtbj1tw2v7DGs2Z3mt1xi6JQjzcqumJjd8Y9Dc81LEG8vwbmrdfgCd93sih3zkp52aHQ84A1wSL+R/lW86OCK7vCPvgya4YI88OK7txxVqNOOzDzyOSqnJwMNS/x3lvxrUuoUKvG351TrUYqDyQLkHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475904; c=relaxed/simple;
	bh=u8b5+VGqoEmZhOF8585gPu7wmWpmwRhjzYHbW1T2LSM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRA0I6B+RbeGR9VQy7D/5nVgERtsrYQ1ZEuDnd3IiHFPmwHXCtEdqtnTk2Gv0bemmPNn9gowIj/k8UnQIl1CGU4PD//bmmM7aKNAtBIvBKIzRCB3MAkJtQ+RvJW1l6ILuBsBJ/4AKdPwifC/hgT5zhUwRg8Jv5EpK1wkT75vImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o86GeSlH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o86GeSlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0232C4CEF0;
	Wed, 10 Sep 2025 03:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757475902;
	bh=u8b5+VGqoEmZhOF8585gPu7wmWpmwRhjzYHbW1T2LSM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=o86GeSlHuLxD5kxBgLSZi3fKCQRhgAyQ/xBV70exk4KgJjf0anzh1VHP76Fv2K47/
	 HBMjBoWbMOXX2+ThXzLetdwbo0jJOStkt82XqNGxZHyqkhEQr2wGfBlBVLg1oRUxwU
	 JAw4h6fVDKfVZ6n8wfs5iIZR6wpzNBmU7LmKA841TkGW1H83Ysd6RzMhu23xg1eXtk
	 rA3FVH1TSmk0oqChxfGZNejxn4kOJe4rLXV99ObbYXGLa6/8ivKW7DEnynLzvIFGlJ
	 1zEcbTwkEZyVnuhsgAAjRouiP5JUz46sJ6frkGKTzXPiOzRI//q0k3LNrtqn22qtzZ
	 C9ZLTHpbEz5Pw==
Message-ID: <4b75974ccfc64501c417a75d697e630821fc02b1.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: remove unused returned value
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 10 Sep 2025 11:44:58 +0800
In-Reply-To: <b46a064d54f6418fe1d61250921674510beb4652.camel@kernel.org>
References: <20250906-check_data_fin_ret-v1-1-2c8100bc20eb@kernel.org>
	 <b46a064d54f6418fe1d61250921674510beb4652.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-09-10 at 11:38 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-09-06 at 16:13 +0200, Matthieu Baerts (NGI0) wrote:
> > When working on a fix modifying mptcp_check_data_fin(), I noticed
> > the
> > returned value was no longer used.
> > 
> > It looks like it was used for 3 days, between commit 7ed90803a213
> > ("mptcp: send explicit ack on delayed ack_seq incr") and commit
> > ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").
> > 
> > This returned value can be safely removed.
> > 
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> LGTM!
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>

Please update the subject when applying this patch, similar to this:

mptcp: remove unused returned value of check_data_fin

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> > ---
> >  net/mptcp/protocol.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index
> > 1c26acf6c4145896ecbb5c7f7004121c66a20649..f3dda47ad1d70b5c6a326c17d
> > be
> > 6d244c5638ca2 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -530,11 +530,10 @@ static void mptcp_cleanup_rbuf(struct
> > mptcp_sock *msk, int copied)
> >  	}
> >  }
> >  
> > -static bool mptcp_check_data_fin(struct sock *sk)
> > +static void mptcp_check_data_fin(struct sock *sk)
> >  {
> >  	struct mptcp_sock *msk = mptcp_sk(sk);
> >  	u64 rcv_data_fin_seq;
> > -	bool ret = false;
> >  
> >  	/* Need to ack a DATA_FIN received from a peer while this
> > side
> >  	 * of the connection is in ESTABLISHED, FIN_WAIT1, or
> > FIN_WAIT2.
> > @@ -572,12 +571,10 @@ static bool mptcp_check_data_fin(struct sock
> > *sk)
> >  			break;
> >  		}
> >  
> > -		ret = true;
> >  		if (!__mptcp_check_fallback(msk))
> >  			mptcp_send_ack(msk);
> >  		mptcp_close_wake_up(sk);
> >  	}
> > -	return ret;
> >  }
> >  
> >  static void mptcp_dss_corruption(struct mptcp_sock *msk, struct
> > sock
> > *ssk)
> > 
> > ---
> > base-commit: e9091ee333eb716a0933dcb08617228dcd3d3623
> > change-id: 20250906-check_data_fin_ret-6d284170880a
> > 
> > Best regards,

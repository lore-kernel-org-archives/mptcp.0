Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143601EF01
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743386090; cv=none; b=Q3wSkYlGDMFaNNonx5QRuYFn/cn1WHEeaid5VHlnc+Xq9ZBwaYqkup6Vf4CiMMaaR7L+kb9HnVHfe+/OGU4HYVBQNdNQPdHchk4Zb65IQ0uhJROkamPRyg2PA0CStmna7xJs/OZAEH2HnsXQTdxdoBWJPeo366dRzYwaURsVtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743386090; c=relaxed/simple;
	bh=QGcGupRiugsJmHAxsKGT4PJiUrZ3Tv9EwE/qKmBQk5k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sf1j5e50I0B53PJZmayS4jyjgT4kF7HCodCXJY1qjvM+85f3ckippk9fOw8UdJpxiIB3mlxPqQcfX5+LtSAnJ1peLlnkfKJ8NQUZp4Vouu3zrtgTT6N2rJfGSrP8MxvkustTKEjmyMU/0dNvFXo6Uy4Wp+ILEnTogovQtqou7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYv67kWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYv67kWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B23C4CEDD;
	Mon, 31 Mar 2025 01:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743386089;
	bh=QGcGupRiugsJmHAxsKGT4PJiUrZ3Tv9EwE/qKmBQk5k=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=rYv67kWn2/eP8w6nApieIWW08inOYS6Y8Qf3NZASrJVdXfQ6em2CWKuJBUemAX+vz
	 kuaIsue6tTSW20fVfukgy5EuvrvOFhqvSIcfCxSlxPXzCT8tBwuUphKfjvAAAH0h81
	 qvqz9mBoyU5ft0Q1NMOxG7aYrwwrWMuoiW492X4R3wTaofctTsgYPbR8oBURDALGKo
	 k8RlSzTexWH5QhDNrgQ+0jf45hJJbNpxKLUHey3O+nZt6T+p7uHiN/uApN3gto6gLu
	 XCr3iPQubgJoV/ormUXguBxbKMYarYzfqsSr5Sy2yPlXRXneL5azs3IOcCt6Tg4TV6
	 HKvjziTBfwdaQ==
Message-ID: <d8213a6016eb048a0834ecfcfcf43972c35a70e0.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/5] mptcp: only inc MPJoinAckHMacFailure for
 HMAC failures
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 31 Mar 2025 09:54:44 +0800
In-Reply-To: <449562cc90538984f6d1df916d645af01163bb72.camel@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
	 <20250329-mptcp-mpj-reject-v1-1-2396d5666e8f@kernel.org>
	 <449562cc90538984f6d1df916d645af01163bb72.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2025-03-31 at 09:28 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-03-29 at 17:26 +0100, Matthieu Baerts (NGI0) wrote:
> > Recently, during a debugging session using local MPTCP connections,
> > I
> > noticed MPJoinAckHMacFailure was not zero on the server side. The
> > counter was in fact incremented when the PM rejected new subflows,
> > because the 'subflow' limit was reached.
> > 
> > The fix is easy, simply dissociating the two cases: only the HMAC
> > validation check should increase MPTCP_MIB_JOINACKMAC counter.
> > 
> > Fixes: 4cf8b7e48a09 ("subflow: introduce and use
> > mptcp_can_accept_new_subflow()")
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > Note: this is a fix for mptcp-net
> > ---
> >  net/mptcp/subflow.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index
> > 409bd415ef1d190d5599658d01323ad8c8a9be93..24c2de1891bdf31dfe04ef207
> > 71
> > 13563aad0e666 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -899,13 +899,17 @@ static struct sock
> > *subflow_syn_recv_sock(const
> > struct sock *sk,
> >  				goto dispose_child;
> >  			}
> >  
> > -			if (!subflow_hmac_valid(req, &mp_opt) ||
> > -			   
> > !mptcp_can_accept_new_subflow(subflow_req->msk)) {
> > +			if (!subflow_hmac_valid(req, &mp_opt)) {
> >  				SUBFLOW_REQ_INC_STATS(req,
> > MPTCP_MIB_JOINACKMAC);
> >  				subflow_add_reset_reason(skb,
> > MPTCP_RST_EPROHIBIT);
> >  				goto dispose_child;
> >  			}
> >  
> > +			if (!mptcp_can_accept_new_subflow(owner))
> > {
> > +				subflow_add_reset_reason(skb,
> > MPTCP_RST_EPROHIBIT);
> > +				goto dispose_child;
> > +			}
> 
> This can be merged with the previous check
> 
> 	if (!owner) {
> 		subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
> 		goto dispose_child;
> 	}
> 
> as:
> 
> 	if (!owner || !mptcp_can_accept_new_subflow(owner)) {
> 		subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
> 		goto dispose_child;
> 	}
> 
> WDYT?

I saw the changes in patch 4, the two checks cannot be merged then.

so this patch LGTM!

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> > +
> >  			/* move the msk reference ownership to the
> > subflow */
> >  			subflow_req->msk = NULL;
> >  			ctx->conn = (struct sock *)owner;
> > 
> 
> 


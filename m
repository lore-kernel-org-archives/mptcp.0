Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACBBA55
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754201459; cv=none; b=JzRPPLo+7iQUaXJHVVsC8Fr2rm6cQh8ujddJxSNi4vdJaPQmx0IkdNKMmvFs7xNDKu1dyy2BrU0O85CNRx+aNhZsTdhBG79dqQRE4QOrVTd2LU+nZHvMIM9TJOvFWfxiu6s5J45yg7isCZvMt/IyJhnM4DLCS56J2/5En3+rxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754201459; c=relaxed/simple;
	bh=wFzQQk+cJdDqgumfwUIQM2pze6CGSDafGEthgd9l+VU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlX9RfROAqv6tkylpga7ZsQuCHKZcY+PxI5cvyOGFNQKpzKO6Ip1w56f6zEoWFbL8HxQHLKqYZeu/UqnlblrJ3lQ5b37LsV4FdOu9SagV5XehlFC2OBrlbRruLWlN4QHi0u0YSf/LLdWO3i7eyRFo4m5pjejyQ+2x/73GwUlYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0PlZa5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0PlZa5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABEAC4CEEB;
	Sun,  3 Aug 2025 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754201458;
	bh=wFzQQk+cJdDqgumfwUIQM2pze6CGSDafGEthgd9l+VU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G0PlZa5Oc9nSWk9fzCDNdeiaTd/Y1oghxGPfowq//yR9Xh/I92LTK9k9Y+aFLGDf5
	 rnwawT41gxn4CAXiZPtVtfbyWuumLQyN2g05LHggIUGy2sYcQDe25LyCzrG+NTOzEf
	 NZ2Pw62HYCmRxQKo+l6R83jJ9GYXmdh21DMgpo8GCGYqPAbD12jfjYysRCFdv8PvbU
	 PY8It2r/bCiJoNc5JOedjoQVLBDjINwxJswWUkKqW0psFHGhq2dtbX/kBUd/3qI+Uj
	 zu++kf+8S6VZBfYEnGMOuLBhGMTO+AxEl+hPowRLPxNiC81Yxzr1/P+5S6BR80SIs1
	 q70Mj311vdwMw==
Message-ID: <0567166cba36ca9d7d0181984ae703eea7068712.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 0/2] mptcp: TCP_MD5SIG support
From: Geliang Tang <geliang@kernel.org>
To: Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 03 Aug 2025 14:10:45 +0800
In-Reply-To: <CADg4-L_VUj4xXLWiUAVF0pGvguwTHPbrh4ixFanaqkWJqOfvkg@mail.gmail.com>
References: <cover.1754135958.git.tanggeliang@kylinos.cn>
	 <CADg4-L_VUj4xXLWiUAVF0pGvguwTHPbrh4ixFanaqkWJqOfvkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

On Sat, 2025-08-02 at 16:27 -0700, Christoph Paasch wrote:
> On Sat, Aug 2, 2025 at 5:01 AM Geliang Tang <geliang@kernel.org>
> wrote:
> > 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v4:
> >  - drop CONFIG_TCP_MD5SIG check.
> >  - drop sk_state check.
> >  - use WARN_ON_ONCE for __mptcp_try_fallback().
> > 
> > v3:
> >  - limit the use of these options for listened and closed state.
> >  - check the return value of __mptcp_try_fallback().
> > 
> > v2:
> >  - trigger fallback to TCP.
> >  - check CONFIG_TCP_MD5SIG.
> >  - update MD5 comment.
> >  - drop selftests, packetdrill tests will be added later.
> > 
> > This series introduces support for TCP_MD5SIG socket options in
> > MPTCP along
> > with code improvements:
> > 
> > Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve code
> > consistency
> > Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT
> > (first
> > subflow only)
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
> > 
> > Geliang Tang (2):
> >   mptcp: Handle TCP_MAXSEG getsockopt in common case
> >   mptcp: setsockopt support for TCP_MD5SIG
> > 
> >  net/mptcp/sockopt.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> When I run these 2 patches, I get a reset from the server :
> 
> 23:24:48.285068 enP22p3s0f0np0 Out IP 10.221.81.117.35206 >
> 10.221.81.118.1234: Flags [S], seq 314447609, win 64240, options
> [nop,nop,md5 shared secret not supplied with -M, can't check -
> bab9b1ba60e4d55efb3d475ee4222311,mss 1460,nop,nop,sackOK,nop,wscale
> 0], length 0
> 23:24:48.285172 enP22p3s0f0np0 In  IP 10.221.81.118.1234 >
> 10.221.81.117.35206: Flags [R.], seq 0, ack 314447610, win 0, options
> [nop,nop,md5 shared secret not supplied with -M, can't check -
> c3bb41109aead9863e97f9cc4e12e7d2], length 0
> 

Yes, indeed, I got this reset too. This patch can fix it:

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 69e773059844..b22daf8c4526 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -165,7 +165,8 @@ static int subflow_check_req(struct request_sock
*req,
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run
out of
 	 * TCP option space.
 	 */
-	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
+	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info) &&
+	    !__mptcp_check_fallback(mptcp_sk(listener->conn))) {
 		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 		return -EINVAL;
 	}

WDYT?

Thanks,
-Geliang

> My test program simply creates a socket (IPPROTO_MPTCP), sets
> TCP_MD5SIG and connects.
> 
> When I use IPPROTO_TCP, everything works.
> 
> I haven't even tried removing wscale,... to make space in the
> TCP-options to try combining both TCP_MD5 and MPTCP.
> 
> 
> Christoph

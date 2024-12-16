Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A122E628
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340267; cv=none; b=FFFdTa9A5LKPc4SU7IOn1GkHTInrDGzekhYJWOvmOGDu2MMVYoclXsJqwSsWKkw00Tr3CZgQ67ua4ctYlG0fqwiQbP4JjLuS0c60CUo7R6bHl9MGzpHAuFhaLY7yCcvNIV90ReVNZABDF5sf/HhNurwbIo5LNU0vZmzGgHIjplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340267; c=relaxed/simple;
	bh=bythSmw5OkIlsBs72kLE2ygXDQmpEbCSPyUkdi1fwjU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A98OA2qFsN+q4OxSCYX17yxl+/U6GgnX7dvXWbFTtTCjH9FkjTBrlghJLe8l7ozRTRGEY/ULZbq3VqI6UeCqRfub8zTlT4GzEso/HBP7fqGrbRTxegdf3HUskOrXbDI3TommkPSC8rvMrnQuhOFRtBu0JtHmXFCfabeAnSNkKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MNLU1Wh2; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MNLU1Wh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1734339952;
	bh=1w6NLiBqPf0KzbDHrLVpqh3ZMfu2EZ45Zqk0P2/GmuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MNLU1Wh22hxhta3RJHiQOsehUFxJvPjXlgtKOENxx3rSCbw+kZmglziayTCyv0TZV
	 c3JMLbWkdXbcN2FeKbyF1j6ImuWwzvyw1G+xau0/yCmqJ+ONlrMNN7K7UxPZ504EDr
	 nY895vttqIujx22nzycEwipV11fGXVPrOP49LTEc=
Received: from localhost ([39.156.73.13])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 172B5C6B; Mon, 16 Dec 2024 17:05:50 +0800
X-QQ-mid: xmsmtpt1734339950t40flio27
Message-ID: <tencent_943B1CC15D1D5654BEB20306FB499F0C3106@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIepJQpDifCe6yMn3HNXchvuftc/H7IBxsVxx7E2dw59a6pETrJgw
	 Uh99NzdjJ4RwZlHmavJstXjhercvxTwNfOnKYncE3G8amHEaaMsuUt8gRlWqyDZ5jzEusrHJXpx5
	 oR90DhWA01JVGq1xP7hXoIG/uH2lZN9oWYN7AEKm3BCLMooUyoBAXb51ad2Fo6yr0pGqGU6XlxgH
	 siOIIKKNNsnUnat7hfB/RHoeeuNMrY1YdEPBvqAV/yA9baN+39vv08Dy5f8CGnCGY2p+wqHtDBQ4
	 UbgMewO5/1o0HNvEf8vEvIipZ/nnw1lRtUcXwMZzbHgJUtg7/9OCytyJilHc6Epxjjn+CM9zFLeE
	 K8H7ZM6xAatfZFqppxlxhDuc4CBh0QAOX0uTHM2PeuYwI1xAvHy8lVw0VAzEB5rzcQuhHqHQ+v82
	 vQl3XM33Ysee2Jv+wB7G3nr2zbQP0Dn4IGrun6MUBP3yTmOG2PpeZIO9VCfZExWzTc/xUHfPZxnX
	 pOUn39Kcq8gX6E/c9VWAquwnPAugZ5j4v8z7FFQRN4SbPrNG+JyoQ51DCuzgbux/Mpeh0ySZshgc
	 PQikngw7bdXD/KOtvgjIKsSNsvJBrgLg0Pd8ktuDwa12UJpNIXtph+dNOakJqJ7jtGrPUjekcXMg
	 9zRqlvTlwFIXAg5hbgA3+EVmWjQsX4Tify2woqsKzW2TYs2TJcWUTTMYFi155TMVNee7kEh7FmNv
	 tXqsA0lSVVbhOmZMQN4wtsr99iJoFDvsrxWQTXKe4E2dah8kI1Yu8DRCt6GLm5OLX5LiORl4cDln
	 hSofRvAHfPAKabWCefsSns3xDP1+kXNVj8jBrUKf7DxSTa/nJGf1EU4oimmu4brhf2sBaBaDuF7r
	 Mxl9eX15x4xfb+SSq88gSC6G555gZwHLUpBmUPItnEntA5avizVl5cMUU87vd6eeZPnn/a1kTpwW
	 bXiLg3JeZnbjg5k8GdoqMDdpv+wSUDU5r6MXM2MTk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Date: Mon, 16 Dec 2024 17:05:50 +0800
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: Re: [mptcp-next] mptcp: fix invalid addr occupy
 'add_addr_accepted'
X-OQ-MSGID: <20241216090550.GA58581@yangang-pc>
References: <tencent_0FE3ED0442E69C9D86C0AEEE338A49F90305@qq.com>
 <902d0bec-abca-4e7c-be43-be2fa1c6ce02@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <902d0bec-abca-4e7c-be43-be2fa1c6ce02@kernel.org>

On Mon, Dec 16, 2024 at 5:00:03PM +0800, Gang Yan wrote:

Hi Matthieu,

Happy to receive your reply!
>On Thu, Dec 12, 2024 at 07:23:02PM +0100, Matthieu Baerts wrote:
> Hi Gang Yan,
> 
> Thank you for this patch!
> 
> I have a few suggestions below. Do you mind sending the next version(s)
> to the MPTCP list only, no need to include the netdev ML and the net
> maintainers for the moment I think.
> 

OK,  sorry for this. I'll be careful next time.

> On 11/12/2024 10:03, Gang Yan wrote:
> > From: Gang Yan <yangang@kylinos.cn>
> > 
> > This patch fixes an issue where an invalid address is announce as a
> > signal, the 'add_addr_accepted' is incorrectly added several times
> > when 'retransmit ADD_ADDR'. So we need to update this variable
> > when the connection is removed from conn_list by mptcp_worker. So that
> > the available address can be added in time.
> > 
> > In fact, the 'add_addr_accepted' is only declined when 'RM_ADDR'
> > by now, so when subflows are getting closed from the other peer,
> 
> Does it mean that in this case, the counter will be decreased twice:
> when the RM_ADDR is received, and when the subflow is closed, no?
> 
> I guess no because you hooked this in a different path, right?

Yes, the counter will not be declined twice.  The RM_ADDR will invoke
mptcp_pm_nl_rm_addr_or_subflow() in pm_netlink.c, which will ignore
the subflow of state '(TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | 
TCPF_CLOSE)' ,  the subflow of these states will turn into 'TCPF_CLOSE'
and finally closed in __mptcp_close_subflow() because of mptcp_worker.

> > the new signal is not accepted as well.
> > 
> > We noticed there have exist some problems related to this.I think
> > this patch effectively resolves them.
> 
> Please add new test cases for these problems in the MPTCP selftests: to
> better understand what is being fixed, and to avoid regressions later.
> 

Actually, I noticed this issue due to "./mptcp_join.sh 28" running failed in my
machine, but passed in docker-virtme, and it can be reproduced very easily. 
That's mainly because the status of  invalid_addr's tcp connection is different. 
It is 'TCPF_SYNC_SENT' in virtme, but  'TCPF_CLOSE' in another. So the 
differences  of states will cause a different return value of 
lookup_subflow_by_daddr() in mptcp_pm_nl_add_addr_received() which will add 
the counter twice when retransmit 'ADD_ADDR'.

Further, I'll add a new test for covering the specific scene.

> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > ---
> >  net/mptcp/protocol.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 21bc3586c33e..f99dddca859d 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2569,6 +2569,10 @@ static void __mptcp_close_subflow(struct sock *sk)
> >                     continue;
> >  
> >             mptcp_close_ssk(sk, ssk, subflow);
> > +
> > +           if (READ_ONCE(subflow->remote_id) &&
> > +               --msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
> > +                   WRITE_ONCE(msk->pm.accept_addr, true);
> Mmh, I don't think it can be that simple: potentially, an accepted
> ADD_ADDR can trigger multiple subflows (i.e. when the fullmesh flag is
> used). In this case, the counter has been incremented once, not once for
> each created subflow. So before decrementing the counter, it should then
> be needed to check if no other subflows connected to the same remote ID
> are still alive.

Thanks for your advice,  sorry for not considering the 'fullmesh' situations, 
the check seems necessary.

> I think it is better not to decrement this counter in "unusual
> situations" -- the situation before this patch -- than wrongly
> decrementing it, and ended up with an underflow.

As the description beyond, the invalid address has caused not accepting
an available address due to this counter, I think we should ensure the
available address can be added at least. And an restrict condition can solve
the underflow problem.

> Another thing is that subflows might have not been created upon the
> reception of an ADD_ADDR: typically if you take the view of a server,
> the subflows have been initiated by the client, and not because the
> server got an ADD_ADDR. If I'm not mistaken, the counter would be
> decremented here as well. We could restrict this by checking
> "subflow->request_join" I suppose. Still, I'm wondering if that's
> covering all cases, 

But does the subflow in server side have 'remote id'? if doesn't, the counter
will not be declined in server side. For covering all cases, I suppose put the 
patch code in '__mptcp_close_ssk', do you think so?

> and if we should not track ADD_ADDR that are received:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/issues/496
> 
> (which is more complex)

For the problem 1 and 3, I noticed there exists 'anno_list' in server side,
and we have timer  for retransmitting 'add_addr', do you think we can 
modify the two modules to fix these problems rather than add a new list.
For the 'add_addr_accepted', I think  using a restrict condition to update 
the counter is enough.

> Also, because this counter is specific to the in-kernel PM, I think it
> would be cleaner f its manipulation is done in pm_netlink.c.
> 
> pw-bot: cr
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 

Thanks for the advices again.

Cheers,
Gang


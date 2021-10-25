Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7282C98
	for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 11:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1635161681; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EKTHoc5FSljOZP6JGTsXZtuLZgTrjbn6iZPaelAkAsGdMvFFDHjYBqTGhsRWOBRKwAcE0L4ySCkGeX0ZkJtyv6GVr/s2+tWTSwg5vmC9yJaB2bcUyWML9yfWs9mpRKIX+NV3RggQ9BorEvzd+kI9cavjKbdQjEb688BPkqszlA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1635161681; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=f46tv3/ezL7i0nn9cSSnX3IA5zI1WYRAolBYuI4SF4k=; 
	b=Jxrez7k7BQXb73RTfaI/0qcnsAUKMVXv/qoP+moz62oAYX/YEmgL09pSsXUBg598W7ak7SZXxiOe/DZctitR1lYFA0tLwu06JOZinSGImI0xgDYYY49PSl87JXzj1XBundH6r1znAcpodj2N1ODvNZZ+4JFn900td2eJdsYFzkg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1635161681;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f46tv3/ezL7i0nn9cSSnX3IA5zI1WYRAolBYuI4SF4k=;
	b=MiVhCxRrH91OxpfoJAuMclzwfwyAqIjj6hV1qlY16Tw5A6I/MmlUo/839T/s63rx
	yyhAb0CGaaCfVD53gmzt7QEvmqNLlfhZhHX8HvqIT51yh7YBz9iOOL3QUWbPGMtUwBF
	Opb1x4LjWDNI5D//6V1Jmexqy1rdePe4KGoLx6AY=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1635161674566237.9042965673973; Mon, 25 Oct 2021 13:34:34 +0200 (CEST)
Date: Mon, 25 Oct 2021 13:34:34 +0200
From: Dmytro Shytyi <dmytro@shytyi.net>
To: "Matthieu Baerts" <matthieu.baerts@tessares.net>
Cc: "mptcp" <mptcp@lists.linux.dev>,
	"mathewjmartineau" <mathew.j.martineau@linux.intel.com>
Message-ID: <17cb73b1343.c752fede1729351.6463099199494289591@shytyi.net>
In-Reply-To: <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net> <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net>
Subject: Re: [PATCH net-next v1] net: mptcp, Fast Open Mechanism
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail


---- On Fri, 22 Oct 2021 11:22:31 +0200 Matthieu Baerts <matthieu.baerts@tessares.net> wrote ----

 > Hi Dmytro, 
 >  
 > (without netdev ML and net maintainers) 
 >  
 > On 22/10/2021 07:15, Dmytro Shytyi wrote: 
 > > This set of patches will bring "Fast Open" Option support to MPTCP. 
 > > The aim of Fast Open Mechanism is to eliminate one round trip 
 > > time from a TCP conversation by allowing data to be included as 
 > > part of the SYN segment that initiates the connection. 
 > > 
 > > IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP. 
 > > 
 > > [PATCH v1] includes "client" partial support for : 
 > > 1. send request for cookie; 
 > > 2. send syn+data+cookie. 
 > > 
 > > Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net> 
 >  
 > Again, thank you for looking at that! 
 >  
 > Here is a very quick review about the code style, just to get that out 
 > from under our feet and not being distracted by that later ;-) 
 > This review is not about the "logic" behind, more about how the code 
 > should look like. 
 >  
 > > --- 
 > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c 
 > > index cd6b11c9b54d..1f9ef060e980 100644 
 > > --- a/net/mptcp/protocol.c 
 > > +++ b/net/mptcp/protocol.c 
 > > @@ -1686,6 +1686,68 @@ static void mptcp_set_nospace(struct sock *sk) 
 > >         set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags); 
 >  
 > It looks like the patch has not been formatting properly: we can see all 
 > tabs have been converted to spaces. 
 > The documentation about how to submit patches [1] is quite long but most 
 > of the time these two commands can be enough to send one patch to MPTCP ML: 
 >  
 >  $ git format-patch --subject-prefix="PATCH mptcp-next" -v2 -1 
 >  $ git send-email --annotate --to "mptcp@lists.linux.dev" <file|dir> 
 >  
 > [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html 
 >  
 > >  } 
 > > 
 > > +static int mptcp_sendmsg_fastopen_cookie_req(struct sock *sk, struct msghdr *msg, 
 > > +                                            size_t *copied, size_t size, 
 > > +                                            struct ubuf_info *uarg) 
 > > +{ 
 > > +       struct mptcp_sock *msk = mptcp_sk(sk); 
 > > +       struct socket *ssk = __mptcp_nmpc_socket(msk); 
 >  
 > For variables declaration in the net tree, we have to follow the 
 > "reversed xmas tree" order: ordered by char size, longest lines first. 
 > So you need to flip the two lines above. Same for the two lines below 
 > and in the next function. 
 >  
 > Sadly, checkpatch doesn't warn you about that. 
 >  
 > > +       struct tcp_sock *tp = tcp_sk(ssk->sk); 
 > > +       struct sockaddr *uaddr = msg->msg_name; 
 > > +       struct tcp_fastopen_context *ctx; 
 > > +       const struct iphdr *iph; 
 > > +       struct sk_buff *skb; 
 > > +       int err; 
 > > + 
 > > +       skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true); 
 > > +       iph = ip_hdr(skb); 
 > > +       tcp_fastopen_init_key_once(sock_net(ssk->sk)); 
 > > +       ctx = tcp_fastopen_get_ctx(ssk->sk); 
 >  
 > It looks like you don't use it. Does the compiler not complain about that? 
 >  
 > > +       tp->fastopen_req = kzalloc(sizeof(*tp->fatopen_req), 
 > > +                                  ssk->sk->sk_allocation); 
 >  
 > After something got allocated, you need to check if you got what you 
 > wanted. If not, you need to revert some actions, usually done at the end 
 > of a function with goto: you can look around in this file for some examples. 
 > In general, you need to look for all possible errors if the function you 
 > call can return some. 
 >  
 > Also, Do not hesitate to create "logical blocks" of code separated by 
 > empty lines, e.g. assigning values in tp->fastopen_req can be done in 
 > one block, the 'return' part in another one, allocating a new skb in 
 > another one, etc. Do not hesitate to look at how it is done around. 
 >  
 > > +       tp->fastopen_req->data = msg; 
 > > +       tp->fastopen_req->size = size; 
 > > +       tp->fastopen_req->uarg = uarg; 
 > > +       err = mptcp_stream_connect(sk->sk_socket, uaddr, msg->msg_namelen, msg->msg_flags); 
 > > +       return err; 
 >  
 > Maybe clearer not to use 'err' if you don't do anything special with it. 
 >  
 > > +} 
 > > + 
 > > +static int mptcp_sendmsg_fastopen_cookie_send(struct sock *sk, struct msghdr *msg, 
 > > +                                             size_t *copied, size_t size, 
 > > +                                             struct ubuf_info *uarg) 
 > > +{ 
 > > +       struct tcp_fastopen_cookie *fastopen_cookie = kmalloc(sizeof(*fastopen_cookie), 
 > > +                                                             GFP_KERNEL); 
 > > +       struct mptcp_sock *msk = mptcp_sk(sk); 
 > > +       struct socket *ssk = __mptcp_nmpc_socket(msk); 
 > > +       struct tcp_sock *tp = tcp_sk(ssk->sk); 
 > > +       struct sockaddr *uaddr = msg->msg_name; 
 > > +       struct tcp_fastopen_context *ctx; 
 > > +       const struct iphdr *iph; 
 > > +       struct sk_buff *skb; 
 > > +       int err; 
 > > + 
 > > +       skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true); 
 > > +       iph = ip_hdr(skb); 
 > > +       tcp_fastopen_init_key_once(sock_net(ssk->sk)); 
 > > +       ctx = tcp_fastopen_get_ctx(ssk->sk); 
 > > + 
 > > +       fastopen_cookie->val[0] = cpu_to_le64(siphash(&iph->saddr, 
 > > +                                             sizeof(iph->saddr) + 
 > > +                                             sizeof(iph->daddr), 
 > > +                                             &ctx->key[0])); 
 > > +       fastopen_cookie->len = TCP_FASTOPEN_COOKIE_SIZE; 
 > > + 
 > > +       tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req), 
 > > +                                  ssk->sk->sk_allocation); 
 > > +       tp->fastopen_req->data = msg; 
 > > +       tp->fastopen_req->size = size; 
 > > +       tp->fastopen_req->uarg = uarg; 
 > > +       memcpy(&tp->fastopen_req->cookie, fastopen_cookie, sizeof(tp->fastopen_req->cookie)); 
 > > +       err = mptcp_stream_connect(sk->sk_socket, uaddr, msg->msg_namelen, msg->msg_flags); 
 > > +       return err; 
 >  
 > (Most of the comments above apply to the code here too. Also, please 
 > check if it is not possible to avoid code duplication by creating other 
 > static functions.) 
 >  
 > > +} 
 > > + 
 > >  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len) 
 > >  { 
 > >         struct mptcp_sock *msk = mptcp_sk(sk); 
 > > @@ -1694,9 +1756,22 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len) 
 > >         int ret = 0; 
 > >         long timeo; 
 > > 
 > > -       /* we don't support FASTOPEN yet */ 
 > > -       if (msg->msg_flags & MSG_FASTOPEN) 
 > > -               return -EOPNOTSUPP; 
 > > +       /* we don't fully support FASTOPEN yet */ 
 > > + 
 > > +       if (msg->msg_flags & MSG_FASTOPEN) { 
 > > +               struct socket *ssk = __mptcp_nmpc_socket(msk); 
 > > +               struct tcp_sock *tp = tcp_sk(ssk->sk); 
 > > + 
 > > +               if (tp && tp->fastopen_req && tp->fastopen_req->cookie.len != 0) { 
 > > +                       // send cookie 
 >  
 > C++-style comments are usually not allowed in the kernel. I thought 
 > checkpatch was saying something about that but maybe it doesn't :) 
 >  
 > > +                       ret = mptcp_sendmsg_fastopen_cookie_send(sk, msg, &copied, len, uarg); 
 > > +               } else { 
 > > +                       struct tcp_fastopen_request *fastopen = tp->fastopen_req; 
 > > +                       //requests a cookie 
 > > +                       ret = mptcp_sendmsg_fastopen_cookie_req(sk, msg, &copied, len, uarg); 
 > > +               } 
 > > +       return ret; 
 >  
 > The alignement is not OK here. 
 > Please also add a new line before to clearly identify the 'return' part 
 > after the 'if/else'. 
 >  
 > I hope this might help reviewing the new versions ;-) 
 
Thank you, Metthieu. 
I'm working on PATCH net-next v2 net: mptcp. It will include all your comments, except this one:

 > It looks like you don't use it. Does the compiler not complain about that? 
 >  
 > > +       tp->fastopen_req = kzalloc(sizeof(*tp->fatopen_req), 
 > > +                                  ssk->sk->sk_allocation); 
Compiler not compalin about that because it is used in the code.


 > Cheers, 
 > Matt 
 > -- 
 > Tessares | Belgium | Hybrid Access Solutions 
 > www.tessares.net 
 

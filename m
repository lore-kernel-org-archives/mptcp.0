Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517072
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 09:22:34 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id y12so1186581eda.4
        for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qiwTbfb0Uua4BcipzbYnAikvz0krQoZ1Xo4dSLmHjqY=;
        b=U68urpyHyk2GH8jIGiiSwtz2avNfPNnKlOqzrmVKKtLtvmCtiT5ch9Ob6/sSctZBOE
         H1rLzSBN/riDepWuJpd3srXH5P27o9JkAusz/kAC0dQrLEs44k8puwg00EjLGOudyf1z
         BmZ9xvNxEc4JNLgU8ongZk0Rj3ZqgwrT/lkvCjxh5DD544gDhkXYPk37OxfN7C6VVV1d
         CwyYJDcciLYGaIb8W2LhPzH3vgHGTmKRsBKfXEOLRCy7lVMUhJgOiu/2NSeVkj6Ul2m6
         rYq4t9P0IEm7u8IjqT5ozLbxbKwOajYINALX4jQZ6p40+8pZfocorl+JGKGXMFkyUYDK
         0b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qiwTbfb0Uua4BcipzbYnAikvz0krQoZ1Xo4dSLmHjqY=;
        b=jb6O5iVo9VfhfWTF/gsZ36lSRAmOicFqGAKyzWsXmJ6VG3Qrq9EA2o3OfyICF6UoRU
         v9GmXU8jOKCBiefssaTciG9VVNX9cEJFNAWPhMytKSBr1I7+41nRMgD/04PQ0mR+xzgW
         E67iTdvjCyOsNj4WivtllEJs5ghE5nB2eCr6AGFE469hlHMhLfE6RfExnfi7tZCYdZWZ
         oIZ+FIwv7Mvr6ZYF9NuQZTiGRkRDWPZ5kZmpxIw1HW/eYCPX8OzvmYJYJ8aSi2adAn0w
         zABFwQbdcW5TsU/I6NGYlm0XbGZlEv9/Fo1IcDrqPWnwJJQ08cGoZ4cDOJrtaj5ztlQI
         4AGg==
X-Gm-Message-State: AOAM531bKJcjXEs8uo/uXgiDOxXR+lpRKDhZdO0JvQL+MMhOxvkutEy7
	QiKlKxovRq4pTHyDREe7mfIU739LAiYSbg==
X-Google-Smtp-Source: ABdhPJynVTUpjFnG7lz4GzpBx8vgz8YI7XkdjEFtpGfRNrhPVgNMssXCBac+q2AUFV5obwJNSMmoWg==
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr13900189eji.126.1634894552937;
        Fri, 22 Oct 2021 02:22:32 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id c8sm3818319edt.55.2021.10.22.02.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 02:22:32 -0700 (PDT)
Message-ID: <a52c4e6d-8463-6328-c786-9cb8b71ac62e@tessares.net>
Date: Fri, 22 Oct 2021 11:22:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH net-next v1] net: mptcp, Fast Open Mechanism
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp <mptcp@lists.linux.dev>,
 mathewjmartineau <mathew.j.martineau@linux.intel.com>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro,

(without netdev ML and net maintainers)

On 22/10/2021 07:15, Dmytro Shytyi wrote:
> This set of patches will bring "Fast Open" Option support to MPTCP.
> The aim of Fast Open Mechanism is to eliminate one round trip 
> time from a TCP conversation by allowing data to be included as 
> part of the SYN segment that initiates the connection. 
> 
> IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.
> 
> [PATCH v1] includes "client" partial support for :
> 1. send request for cookie;
> 2. send syn+data+cookie.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

Again, thank you for looking at that!

Here is a very quick review about the code style, just to get that out
from under our feet and not being distracted by that later ;-)
This review is not about the "logic" behind, more about how the code
should look like.

> ---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cd6b11c9b54d..1f9ef060e980 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1686,6 +1686,68 @@ static void mptcp_set_nospace(struct sock *sk)
>         set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);

It looks like the patch has not been formatting properly: we can see all
tabs have been converted to spaces.
The documentation about how to submit patches [1] is quite long but most
of the time these two commands can be enough to send one patch to MPTCP ML:

  $ git format-patch --subject-prefix="PATCH mptcp-next" -v2 -1
  $ git send-email --annotate --to "mptcp@lists.linux.dev" <file|dir>

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

>  }
> 
> +static int mptcp_sendmsg_fastopen_cookie_req(struct sock *sk, struct msghdr *msg,
> +                                            size_t *copied, size_t size,
> +                                            struct ubuf_info *uarg)
> +{
> +       struct mptcp_sock *msk = mptcp_sk(sk);
> +       struct socket *ssk = __mptcp_nmpc_socket(msk);

For variables declaration in the net tree, we have to follow the
"reversed xmas tree" order: ordered by char size, longest lines first.
So you need to flip the two lines above. Same for the two lines below
and in the next function.

Sadly, checkpatch doesn't warn you about that.

> +       struct tcp_sock *tp = tcp_sk(ssk->sk);
> +       struct sockaddr *uaddr = msg->msg_name;
> +       struct tcp_fastopen_context *ctx;
> +       const struct iphdr *iph;
> +       struct sk_buff *skb;
> +       int err;
> +
> +       skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
> +       iph = ip_hdr(skb);
> +       tcp_fastopen_init_key_once(sock_net(ssk->sk));
> +       ctx = tcp_fastopen_get_ctx(ssk->sk);

It looks like you don't use it. Does the compiler not complain about that?

> +       tp->fastopen_req = kzalloc(sizeof(*tp->fatopen_req),
> +                                  ssk->sk->sk_allocation);

After something got allocated, you need to check if you got what you
wanted. If not, you need to revert some actions, usually done at the end
of a function with goto: you can look around in this file for some examples.
In general, you need to look for all possible errors if the function you
call can return some.

Also, Do not hesitate to create "logical blocks" of code separated by
empty lines, e.g. assigning values in tp->fastopen_req can be done in
one block, the 'return' part in another one, allocating a new skb in
another one, etc. Do not hesitate to look at how it is done around.

> +       tp->fastopen_req->data = msg;
> +       tp->fastopen_req->size = size;
> +       tp->fastopen_req->uarg = uarg;
> +       err = mptcp_stream_connect(sk->sk_socket, uaddr, msg->msg_namelen, msg->msg_flags);
> +       return err;

Maybe clearer not to use 'err' if you don't do anything special with it.

> +}
> +
> +static int mptcp_sendmsg_fastopen_cookie_send(struct sock *sk, struct msghdr *msg,
> +                                             size_t *copied, size_t size,
> +                                             struct ubuf_info *uarg)
> +{
> +       struct tcp_fastopen_cookie *fastopen_cookie = kmalloc(sizeof(*fastopen_cookie),
> +                                                             GFP_KERNEL);
> +       struct mptcp_sock *msk = mptcp_sk(sk);
> +       struct socket *ssk = __mptcp_nmpc_socket(msk);
> +       struct tcp_sock *tp = tcp_sk(ssk->sk);
> +       struct sockaddr *uaddr = msg->msg_name;
> +       struct tcp_fastopen_context *ctx;
> +       const struct iphdr *iph;
> +       struct sk_buff *skb;
> +       int err;
> +
> +       skb = sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
> +       iph = ip_hdr(skb);
> +       tcp_fastopen_init_key_once(sock_net(ssk->sk));
> +       ctx = tcp_fastopen_get_ctx(ssk->sk);
> +
> +       fastopen_cookie->val[0] = cpu_to_le64(siphash(&iph->saddr,
> +                                             sizeof(iph->saddr) +
> +                                             sizeof(iph->daddr),
> +                                             &ctx->key[0]));
> +       fastopen_cookie->len = TCP_FASTOPEN_COOKIE_SIZE;
> +
> +       tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req),
> +                                  ssk->sk->sk_allocation);
> +       tp->fastopen_req->data = msg;
> +       tp->fastopen_req->size = size;
> +       tp->fastopen_req->uarg = uarg;
> +       memcpy(&tp->fastopen_req->cookie, fastopen_cookie, sizeof(tp->fastopen_req->cookie));
> +       err = mptcp_stream_connect(sk->sk_socket, uaddr, msg->msg_namelen, msg->msg_flags);
> +       return err;

(Most of the comments above apply to the code here too. Also, please
check if it is not possible to avoid code duplication by creating other
static functions.)

> +}
> +
>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>         struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -1694,9 +1756,22 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         int ret = 0;
>         long timeo;
> 
> -       /* we don't support FASTOPEN yet */
> -       if (msg->msg_flags & MSG_FASTOPEN)
> -               return -EOPNOTSUPP;
> +       /* we don't fully support FASTOPEN yet */
> +
> +       if (msg->msg_flags & MSG_FASTOPEN) {
> +               struct socket *ssk = __mptcp_nmpc_socket(msk);
> +               struct tcp_sock *tp = tcp_sk(ssk->sk);
> +
> +               if (tp && tp->fastopen_req && tp->fastopen_req->cookie.len != 0) {
> +                       // send cookie

C++-style comments are usually not allowed in the kernel. I thought
checkpatch was saying something about that but maybe it doesn't :)

> +                       ret = mptcp_sendmsg_fastopen_cookie_send(sk, msg, &copied, len, uarg);
> +               } else {
> +                       struct tcp_fastopen_request *fastopen = tp->fastopen_req;
> +                       //requests a cookie
> +                       ret = mptcp_sendmsg_fastopen_cookie_req(sk, msg, &copied, len, uarg);
> +               }
> +       return ret;

The alignement is not OK here.
Please also add a new line before to clearly identify the 'return' part
after the 'if/else'.

I hope this might help reviewing the new versions ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

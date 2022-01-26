Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08542CA3
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643213690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a6A2Gtofsm2HKTZH/NWhF5dXN/QL0bQRjpEmX65zn4Y=;
	b=ZK0gSR0OvkRExsF4gJmaIlvXvQ818AuLHonNT098YTT4Y6lFccJMAEgO0Z89sTbc/G0qGm
	+QFIsmqlxtJjY00o13rZE94acjJxTZSOf/pNWL6M4l2SckRNfK3RZLdfjMmc3eRPlGmoIM
	skzIBj48TNRLsq6mMoRaP6pJfbhYAYk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-0xnMKWyhNNiDUHdSReHghg-1; Wed, 26 Jan 2022 11:14:47 -0500
X-MC-Unique: 0xnMKWyhNNiDUHdSReHghg-1
Received: by mail-qv1-f70.google.com with SMTP id r12-20020a0562140c8c00b004226c4fc035so273461qvr.4
        for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 08:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=fysXeXh1WW6YVve6gUqELrIgjARZKl2Vh28eeLnVfZQ=;
        b=MbPbYOoG5Ca86gyDgP6hzSj/WMcgvDXzNhhi4DNtAE2RX7tphVAtvKIvJgIMfOy1X4
         Uuk/BNkhfbu0FDIwFoDgf55LZhMvB9ibcveDRWISzIYP7gAAZgrFGcA0xFUM+z+vyicK
         Kvc8lhNF3tSaoeIYnGDBcprW6iFfyixDpgnAynf3LwW0BF+VxFmHFbkPswbjg2U8RA8e
         gQ+yxi/wt+LepdiSxzzG04i2rJtNDPjhiz4QSGomrhxeYFbpZpUvawES7CTB1mZvXaMT
         tYuNqSaToVNacCwJjZwxyjQ5qjIjroeJTcBA0nttQh+7HZj/GH0LpUVkrb4CBH08ZSpn
         Xh4Q==
X-Gm-Message-State: AOAM532L67fIT3DU8MvZUNPrInb3ex2DQ3Fz/0IhgN4TJx2LYtfxbu7a
	bnHdhp0q+g1rzpEg9TIZfY3w97oUANWriMl070UtQGdFCCtcsrUII0dDFzG3dwT1o9eiVCQ8nlU
	OddH1K2v9xuwh4QI=
X-Received: by 2002:a05:620a:4450:: with SMTP id w16mr18960194qkp.340.1643213686775;
        Wed, 26 Jan 2022 08:14:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybO+VZrDyMSpaH2QEaia6yUqym/IYy2hLS2N/KGMzG5CMLHY7PhfIqb74i025vJ2KJWTEnwQ==
X-Received: by 2002:a05:620a:4450:: with SMTP id w16mr18960171qkp.340.1643213686490;
        Wed, 26 Jan 2022 08:14:46 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id b23sm10165798qtp.94.2022.01.26.08.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:14:45 -0800 (PST)
Message-ID: <6cccaaa7854c98248d663f60404ab6163250107f.camel@redhat.com>
Subject: Re: [PATCH net-next 6/6] ipv4/tcp: do not use per netns ctl sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <eric.dumazet@gmail.com>, "David S . Miller"
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	mptcp@lists.linux.dev
Date: Wed, 26 Jan 2022 17:14:42 +0100
In-Reply-To: <20220124202457.3450198-7-eric.dumazet@gmail.com>
References: <20220124202457.3450198-1-eric.dumazet@gmail.com>
	 <20220124202457.3450198-7-eric.dumazet@gmail.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="=-JZLwH+BnmnbBU710Mfv4"

--=-JZLwH+BnmnbBU710Mfv4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,
On Mon, 2022-01-24 at 12:24 -0800, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> TCP ipv4 uses per-cpu/per-netns ctl sockets in order to send
> RST and some ACK packets (on behalf of TIMEWAIT sockets).
> 
> This adds memory and cpu costs, which do not seem needed.
> Now typical servers have 256 or more cores, this adds considerable
> tax to netns users.
> 
> tcp sockets are used from BH context, are not receiving packets,
> and do not store any persistent state but the 'struct net' pointer
> in order to be able to use IPv4 output functions.
> 
> Note that I attempted a related change in the past, that had
> to be hot-fixed in commit bdbbb8527b6f ("ipv4: tcp: get rid of ugly unicast_sock")
> 
> This patch could very well surface old bugs, on layers not
> taking care of sk->sk_kern_sock properly.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

We are observing UaF in our self-tests on top of this patch:

https://github.com/multipath-tcp/mptcp_net-next/issues/256

While I can't exclude the MPTCP code is misusing sk_net_refcnt and/or
sk_kern_sock, we can reproduce the issue even with plain TCP sockets[1]

The kasan report points to:

	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;

in inet_twsk_kill(). Apparently tw->tw_dr still refers to:

	&sock_net(sk)->ipv4.tcp_death_row

and the owning netns has been already dismantelled, as expected.
I could not find any code setting tw->tw_dr to a safe value after netns
destruction?!? am I missing something relevant?

Thanks!

Paolo

[1] patching the selftest script with the attached patch and running it
in a loop:

while ./mptcp_connect.sh -t -t; do : ; done

--=-JZLwH+BnmnbBU710Mfv4
Content-Disposition: attachment; filename="selftests_tcp.patch"
Content-Type: text/x-patch; name="selftests_tcp.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9jb25u
ZWN0LnNoIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2Nvbm5lY3Qu
c2gKaW5kZXggY2I1ODA5Yjg5MDgxLi4xNTJkMzk1OTE2ODIgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9jb25uZWN0LnNoCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9jb25uZWN0LnNoCkBAIC02MDksOCArNjA5
LDggQEAgcnVuX3Rlc3RzX2xvKCkKIAkJbG9jYWxfYWRkcj0iMC4wLjAuMCIKIAlmaQogCi0JZG9f
dHJhbnNmZXIgJHtsaXN0ZW5lcl9uc30gJHtjb25uZWN0b3JfbnN9IE1QVENQIE1QVENQIFwKLQkJ
ICAgICR7Y29ubmVjdF9hZGRyfSAke2xvY2FsX2FkZHJ9ICIke2V4dHJhX2FyZ3N9IgorCSNkb190
cmFuc2ZlciAke2xpc3RlbmVyX25zfSAke2Nvbm5lY3Rvcl9uc30gTVBUQ1AgTVBUQ1AgXAorCSMJ
ICAgICR7Y29ubmVjdF9hZGRyfSAke2xvY2FsX2FkZHJ9ICIke2V4dHJhX2FyZ3N9IgogCWxyZXQ9
JD8KIAlpZiBbICRscmV0IC1uZSAwIF07IHRoZW4KIAkJcmV0PSRscmV0CkBAIC02MjQsMTYgKzYy
NCwxNiBAQCBydW5fdGVzdHNfbG8oKQogCQlmaQogCWZpCiAKLQlkb190cmFuc2ZlciAke2xpc3Rl
bmVyX25zfSAke2Nvbm5lY3Rvcl9uc30gTVBUQ1AgVENQIFwKLQkJICAgICR7Y29ubmVjdF9hZGRy
fSAke2xvY2FsX2FkZHJ9ICIke2V4dHJhX2FyZ3N9IgorCSNkb190cmFuc2ZlciAke2xpc3RlbmVy
X25zfSAke2Nvbm5lY3Rvcl9uc30gTVBUQ1AgVENQIFwKKwkjCSAgICAke2Nvbm5lY3RfYWRkcn0g
JHtsb2NhbF9hZGRyfSAiJHtleHRyYV9hcmdzfSIKIAlscmV0PSQ/CiAJaWYgWyAkbHJldCAtbmUg
MCBdOyB0aGVuCiAJCXJldD0kbHJldAogCQlyZXR1cm4gMQogCWZpCiAKLQlkb190cmFuc2ZlciAk
e2xpc3RlbmVyX25zfSAke2Nvbm5lY3Rvcl9uc30gVENQIE1QVENQIFwKLQkJICAgICR7Y29ubmVj
dF9hZGRyfSAke2xvY2FsX2FkZHJ9ICIke2V4dHJhX2FyZ3N9IgorCSNkb190cmFuc2ZlciAke2xp
c3RlbmVyX25zfSAke2Nvbm5lY3Rvcl9uc30gVENQIE1QVENQIFwKKwkjCSAgICAke2Nvbm5lY3Rf
YWRkcn0gJHtsb2NhbF9hZGRyfSAiJHtleHRyYV9hcmdzfSIKIAlscmV0PSQ/CiAJaWYgWyAkbHJl
dCAtbmUgMCBdOyB0aGVuCiAJCXJldD0kbHJldApAQCAtNzE2LDggKzcxNiw4IEBAIEVPRgogCiAJ
VEVTVF9DT1VOVD0xMDAwMAogCWxvY2FsIGV4dHJhX2FyZ3M9Ii1vIFRSQU5TUEFSRU5UIgotCWRv
X3RyYW5zZmVyICR7bGlzdGVuZXJfbnN9ICR7Y29ubmVjdG9yX25zfSBNUFRDUCBNUFRDUCBcCi0J
CSAgICAke2Nvbm5lY3RfYWRkcn0gJHtsb2NhbF9hZGRyfSAiJHtleHRyYV9hcmdzfSIKKwkjZG9f
dHJhbnNmZXIgJHtsaXN0ZW5lcl9uc30gJHtjb25uZWN0b3JfbnN9IE1QVENQIE1QVENQIFwKKwkj
CSAgICAke2Nvbm5lY3RfYWRkcn0gJHtsb2NhbF9hZGRyfSAiJHtleHRyYV9hcmdzfSIKIAlscmV0
PSQ/CiAKIAlpcCBuZXRucyBleGVjICIkbGlzdGVuZXJfbnMiIG5mdCBmbHVzaCBydWxlc2V0Cg==

--=-JZLwH+BnmnbBU710Mfv4--


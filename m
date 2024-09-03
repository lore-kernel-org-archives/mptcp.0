Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249C188903
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376740; cv=none; b=LY8x8GVqGlGpiPhV6AlANnXbpcBfikq6uS+h7MRHReTDt8450aKM5lDtx8+fIJ4wyjelOGDkWjzwFH70PT7AJPp+K9kUH2VUsWaSiFpnihavc1MEEfvOlwUI/ybMcjLbFKpn39YgjOWSdsLTsyjn3YWrOydn0E1zFO+1JgIlbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376740; c=relaxed/simple;
	bh=ZfbxVl1glz8Vb6LZs4MHn8WObItPWAp5Hu0aYunUFeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsnCHc251Cx8K2B+LBsCiU8SQ08YS+80ipmdIe9h1xS68MaMDXb/3C5saE84db+G7oOtuRb+pQ+x/UaR6GhtGoJWkm5u9Q631aLo+pg2Wmk6U/anFTMTQCR0XzqzPnucFoKneHjz/8CkxYHAnUe5CMjcmaMOaaoPxYjc2lNjJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xne1qnvo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xne1qnvo"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86abbd68ffso907428966b.0
        for <mptcp@lists.linux.dev>; Tue, 03 Sep 2024 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725376737; x=1725981537; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJsBRI3EdlxNC+/ozkYJ5K4YtqaBU+Qz7tDZo9enfoQ=;
        b=xne1qnvous6jzLNWYJX++3r0D2E0/jrivmbaRIj3c8zZNZ4mkacKABvJNBXtBObIT7
         EBQtleXvUZXbagbFE4gOWt2ceQG0yfPdC2JksOabHfS+v8iXBI2nPNZCz7jtqU+011q/
         G4bX+JL0KEmPIbZq3ysSgZNX4eYBWeuOvKJZGXXuSCemmkJnNTdvJAs1PBOUjETGGnnc
         btkGT9tguVykTQ8bA+VAXfy86yaB1CUr1tlKX1t4v5g7Dr9hINeZuBQhhlt7N3PD6yw8
         e2qFlle2/CE2tRB/zvBd80zMwC4vFHAmfzAC4RUh9oboFEN7LwrbU3ng9q1wmKH3TlTa
         ddpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376737; x=1725981537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJsBRI3EdlxNC+/ozkYJ5K4YtqaBU+Qz7tDZo9enfoQ=;
        b=DF5HoLjaj5dvmqpE/Slt5SX8Ei15eILfu74cpsveAal0wJ1o2/B2DPzPga142UVB56
         GLQa9CcREUZPgSOPA6hABBC74BYuRYU/0tJEDaLeeFu1DgoI2OyM2uPHs8c7d5w9WPDP
         S8d4UZHy2y5lZLv9+20kUzSQ6dMEAwyzGS1nKZbjIIXeMTEYNKYy8M/23ryFXtnMr0zC
         XiTDumcl1Y7p+tavCpfaNvTUu2zPSbuvspibEuQk7pD6abxGDEgKV5f6RjtbkbvcZiXt
         zJ6KcXx2BN6FIvonHZKhP5Sxhb4i0bznvKrVImJn8Mpyt+v3dtXOqoLLRKWaNFjmPc/A
         IRqw==
X-Forwarded-Encrypted: i=1; AJvYcCVEjAsMUDFfBoQDAYCJc72SSCM4vPlTAAUK3APC1kxQNRWCp4p/eTZUKul+yiyPQqckyuToqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhwwvKbF9ir9Zb8cA/xm0paDbgQnh1lrBIQSZPXkej6P0pQ9I/
	6OgvONGAZoJAgt4LUQBl3wz4XBAvJoBIXfpQmUF6TkjmQUqQ1bFjXhYq9HxcUE+slN1RuU9fPSa
	weUjcXODGEeQkY9g9rQWGNRnjmtaZhKyYILRr
X-Google-Smtp-Source: AGHT+IGJJzBIkDzFW1Sjp3ZP4my3ZSX2A8AzHH2EQ2hAxnP3UhDE2BBhdsJQm6BR5aRg54MNzRlcOiw2WpTTTHJTtnI=
X-Received: by 2002:a17:907:1ca7:b0:a7d:895b:fd with SMTP id
 a640c23a62f3a-a898231fd75mr1775714366b.6.1725376736022; Tue, 03 Sep 2024
 08:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <000000000000b341bb062136d2d9@google.com> <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
In-Reply-To: <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Sep 2024 17:18:42 +0200
Message-ID: <CANn89i+93oK80FtHijdYJMid=ChsXP+2F1=Dn7K8tuvLy7xNHA@mail.gmail.com>
Subject: Re: [PATCH] mptcp: pm: Fix uaf in __timer_delete_sync
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com, davem@davemloft.net, 
	geliang@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:10=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> There are two paths to access mptcp_pm_del_add_timer, result in a race
> condition:
>
>      CPU1                               CPU2
>      =3D=3D=3D=3D                               =3D=3D=3D=3D
>      net_rx_action
>      napi_poll                          netlink_sendmsg
>      __napi_poll                        netlink_unicast
>      process_backlog                    netlink_unicast_kernel
>      __netif_receive_skb                genl_rcv
>      __netif_receive_skb_one_core       netlink_rcv_skb
>      NF_HOOK                            genl_rcv_msg
>      ip_local_deliver_finish            genl_family_rcv_msg
>      ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
>      tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
>      tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
>      tcp_rcv_established                mptcp_pm_remove_addrs_and_subflow=
s
>      tcp_data_queue                     remove_anno_list_by_saddr
>      mptcp_incoming_options             mptcp_pm_del_add_timer
>      mptcp_pm_del_add_timer             kfree(entry)
>
> In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
> zone protected by "pm.lock", the entry will be released, which leads to t=
he
> occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).
>
> Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df3a31fb909db9b2a5c4d
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/mptcp/pm_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 3e4ad801786f..d28bf0c9ad66 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -336,11 +336,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>         entry =3D mptcp_lookup_anno_list_by_saddr(msk, addr);
>         if (entry && (!check_id || entry->addr.id =3D=3D addr->id))
>                 entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
> -       spin_unlock_bh(&msk->pm.lock);
>
>         if (entry && (!check_id || entry->addr.id =3D=3D addr->id))
>                 sk_stop_timer_sync(sk, &entry->add_timer);
>
> +       spin_unlock_bh(&msk->pm.lock);


mptcp_pm_add_timer() needs to lock msk->pm.lock

Your patch might add a deadlock, because sk_stop_timer_sync() is
calling del_timer_sync()

What is preventing this ?

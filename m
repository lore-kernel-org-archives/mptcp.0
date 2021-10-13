Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDF2C80
	for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 15:16:50 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id t16so11680237eds.9
        for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pQBDukMFvp9fRExYqsRTphhRzAr8BHrdYP1jBGZmw+U=;
        b=Zd3AQxg0gJgm4f90412UdiaxzKgEAGti6mhnBuPt1znWZyzI5ROXOps+jeDV4ETF6h
         3R6jx+w5Pnl1JwEsHFvFTyJyIpyQSiPaaxEopgszwDfavsajTIhWXUN1hBLbxrhbA07z
         iw1ZK9KRaYgiZndi1KW4mcjNpqLjzsW/wHe0jvfJhe3tuAd0H5o+heYRbVuVdxvL+hyc
         Q5hIZIWDXICohpy5SxVOM5ryH7K9VZ2Hl1YXGADODVPorGfNvxGKXl+cLm/2eEyENcZG
         nEE7c8NYjmCChYk9M804nh8+ODRIuOBr/UGLgqwzTr99D2hWXQQW4mDiganLNz3nY3nl
         ft1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=pQBDukMFvp9fRExYqsRTphhRzAr8BHrdYP1jBGZmw+U=;
        b=WbFHBsMULRsTHG0rdVwY82IAhTAK7id13r5mpXiva1ykUx84gOOSG/PmP4oEvDksSt
         b09zSTzrCeyAKkxrKB+Hamm2Ofpul7Jn2EBXfjDFU0d3G9E3y/Eo0Lwtl/m83DOZqXk8
         O5LOxPKILbZ48xaRcNYcPuTLvRDjgpxWN7HVSF6XAuemnBZxzALFBVhxAVtGMYcN009x
         goobulvzS60RhHTpxaXkAijM3/LdAc7kVa9DVfgK8IKiwLJmCBloNJnD8rj9alddjxGX
         1E/ruFwAVM+kKtFIjR4CxqM1vjAhYh6vEd7nTaGdvvLKu67eocm2AclnCcc+doIG48zX
         KYkA==
X-Gm-Message-State: AOAM532taMd/5uKQxy0K3nRR+JcL5uOZVx2NXP4ukqF+OP7tJFvAiGWU
	mUM13MTx7hNbabeIee4GIEooXMjXOv+LyoNP5gtHJL0Tr14=
X-Google-Smtp-Source: ABdhPJxLP4q6zpaMDlvZrIuk97SdRKDiNtB904NB16WXoRt/9kjAtF2tm2Uepf9UDeyTWM0rRtd0EIpLYjsl4I25NyA=
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr10769499edc.272.1634138209268;
 Wed, 13 Oct 2021 08:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACry=t6JVP+5AUUs7KggjMhQirQvyQsVhJiXgM38xK1v=6qh9w@mail.gmail.com>
In-Reply-To: <CACry=t6JVP+5AUUs7KggjMhQirQvyQsVhJiXgM38xK1v=6qh9w@mail.gmail.com>
From: Paolo Abeni <paolo.abeni@gmail.com>
Date: Wed, 13 Oct 2021 17:16:38 +0200
Message-ID: <CAAHOsNv41B45ahxYsC1Xq7Ri3Hryt5m8GscFd51fY=S1NT8ccA@mail.gmail.com>
Subject: Re: MPTCP with Python issue
To: Robert Bowyer <robert.bowyer@flylogix.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 13, 2021 at 3:16 PM Robert Bowyer
<robert.bowyer@flylogix.com> wrote:
> Hope this finds you well and hope it is ok to contact you directly.

Please, use the mptcp devel mailing list for this kind of question
(just cc-ed) or the github issue tracker at:

https://github.com/multipath-tcp/mptcp_net-next/issues

> I am really struggling to get MPTCP working on Linux 5.10.68 with Python =
3.9.5 asyncio and seek your guidance:

This kernel version is quite old, and lacks quite a few features. I
suggest moving to a newer one, if possible.
Have a look at the "changelog" section in:

https://github.com/multipath-tcp/mptcp_net-next/wiki

for the details of what you are missing.

> 1. I used eBPF mptcp.stap on the server to override __sys_socket() as per=
 https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/h=
tml/configuring_and_managing_networking/getting-started-with-multipath-tcp_=
configuring-and-managing-networking
>
> 2.  I don't have system tap on by embedded system so made a simple lib to=
 do same:
> /* Define pointer to original socket function */
> int (*orig_socket)( int family, int type, int protocol );

You can also use the mptcpize command line tool, bundled with the
mptcpd package, see:

https://github.com/intel/mptcpd
https://github.com/intel/mptcpd/blob/master/src/mptcpize.c
https://github.com/intel/mptcpd/blob/master/man/mptcpize.8.in

[...]
> 4. But if I use python asyncio
> conn =3D asyncio.open_connection(config.FX_TCP_SERVER_ADDR, config.FX_TCP=
_SERVER_PORT, ssl=3Dssl_ctx)
>
> I get an initial MPTCP override and the it reverts to TCP:

[ image removed; wireshark shows syn+MPC from the client and syn+ack
_without_ MPC from the server]

[...]
> It would appear the system is not able to handle  TCP_NODELAY option   se=
tsockopt(6, SOL_TCP, TCP_NODELAY, [1], 4) =3D 0
>
> Do you know if this is fixed in later kernels or if there is a better way=
 to do this ?

TCP_NODELAY is still unsupported for MPTCP sockets. The setsockopt is
successful, but has no effect. Feel free to open an issue on the
github tracker at:

https://github.com/multipath-tcp/mptcp_net-next/issues

about that. I don't think this is the root of the TCP fallback you are
observing.

> Any help greatly appreciated as am really stuck !

WRT to the failing MPC handshake, It looks like the python client is
MPTCP-enabled, but the server is not. Are you doing syscall hijacking
on the server, too? Try to attach the strace tool on the server
program, too. And look at the MIB counters just before and just after
the connection:

nstat MPTcp*
# do the connect
nstat MPTcp*

If you could provide a pcap trace with the first few pkts in the
connection, that could be helpful.

Additionally, feel free to open a tracker for this specific issue (a
different one WRT the TCP_NODELAY one).

Cheers,

Paolo

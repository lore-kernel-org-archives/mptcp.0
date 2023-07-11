Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D6168AA
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 12:43:59 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5703d12ab9aso68381017b3.2
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689079439; x=1691671439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dr3lSUgu3oePgJRnnQUffOfeUlEV2prqK7kAgHSjTFU=;
        b=N4LUE0TGXVV/Y5TgwH07P6NgO7g2pSJISWyg3NqsfPKu3Ma/ewk/AFmKuWVxrbJCNk
         wfS0v2tP53zA2y5ODGNIQY9ISYfLjatlvSZjWMY3Rk/c1nCXJ5Mmtfev998LuFHwB13R
         EXW0qH/+SL4buFpOmop519XKOQt5iZYEWIgt0xuJO/12yd2RBzFMbdeSMl3cQG5vt5rZ
         M0m8R+btAfWCPrQw1uR7tzBOoVkueRLQTdMG/ZESojX9ZwSOflQo1okqkO75jk0JEd4l
         4LOFFrUwNFTMP9dlJBBeGqHwST1GQ9f69MoWPn4ergOfQFNppZ5+1RvtuSJm4o5ywgN8
         vUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689079439; x=1691671439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dr3lSUgu3oePgJRnnQUffOfeUlEV2prqK7kAgHSjTFU=;
        b=UZANVcLvbR4BAazFnmgUNiD2MGF9yTDqYGgx4oWZk12HpmcEttZK18Lszc61bQxJ5m
         NF0Y3AWx4TKHwuYh3R0SG0CX5UanNGbPoBIdCpT37elKAVI4UqGqEN8DPF9pOAjpYzJa
         c4GrhPIPKY8WHrfl8INzz1b3r3XIhZOqR9YUGJ6nc8cn3vtFWJjs0HYwQt/0gcnq24xd
         iH3kBZqlavcub5pNh+BAEeHl9zMQhCliStTb+of7dnKfIcrzV/Laiqf/RschXpDys2Kf
         02TTEA3QILLKPNlDy+/LRUBx2t0wDpj6dKiWs9fX7Q1o+XXA10tkHKw83Kh1EsGlxVmo
         kDNQ==
X-Gm-Message-State: ABy/qLb4THRdg58ghUIu7/QzyG0ENSzIHARvnbZ/fcMvLCQIC6HUkgw5
	2jDTGNyyXh7vyf+kiaIoQDMn8Ekmsy3G0tYyPNjle+SVoZc=
X-Google-Smtp-Source: APBJJlFwuhgIzxjCT5H1JTU9kAg5B0yr9s/XUvAx83MXkydI4ZqTfA6YbDmOM75dN2D2dFrFbmynoRE9YeQanTRYDCg=
X-Received: by 2002:a25:6d88:0:b0:c61:ea22:8e1d with SMTP id
 i130-20020a256d88000000b00c61ea228e1dmr12022735ybc.48.1689079438753; Tue, 11
 Jul 2023 05:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJck1w2+nhbiEsa8+oYvbicruru2nsVbHNMWut1HqGrhZ5nhtw@mail.gmail.com>
 <fdea425d-5a7e-4d85-bcfe-4e624ab25e91@tessares.net>
In-Reply-To: <fdea425d-5a7e-4d85-bcfe-4e624ab25e91@tessares.net>
From: parthaz lokesh <parthazlokesh@gmail.com>
Date: Tue, 11 Jul 2023 18:13:47 +0530
Message-ID: <CAJck1w1pgBQN5RPjXF9crdkcrhN31z0frTwAA8ALk4uzSw0TMQ@mail.gmail.com>
Subject: Re: mptcpize with shadow socks in android
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Matt,

Thanks for your quick feedback. I figured out a way. Currently, the
Android device is my client device. I'm using the redsocks client on
the device to connect to the shadow socks server which is installed in
the server. From the client side, I'm able to redirect any application
traffic to redsocks where I'm  opening socket with IPPROTO_MPTCP.
MPTCP flags are seen in pcap collected on the client. So everthings
fine from client.

However, on the server side, I followed the tutorial from
https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/. But,
mptcp packets are not seen in pcap. only tcp packets are there. Do we
have to redirect application traffic to shadowsocks to make MPTCP
work? or just below commands should take care of redirection to socks
and converting any tcp packets to mptcp packets? If so, it is not
working as expected. Could you please guide?

Commands executed in my server:
sudo apt install shadowsocks-libev mptcpize rng-tools5
sudo mptcpize enable shadowsocks-libev.service
sudo systemctl restart shadowsocks-libev.service

Below is my server configuration:
Ubuntu 22.04
kernel 5.19v.
enabled value is 1 from /proc/sys/net/mptcp

Thanks,
Parthaz.


On Tue, 20 Jun 2023 at 21:00, Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Parthaz,
>
> On 20/06/2023 13:32, parthaz lokesh wrote:
> > I set up a server for MPTCPV1 using (
> > https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/ ).
> > However, for clients I'm trying to use an android smartphone with
> > kernel 5.15v.
> > Is there a way I can force tcp sockets to use mptcp sockets in android
> > smartphones?
>
> Good question. Personally, I don't know.
>
> When I did experimentations in the past with Android devices, I had to
> modify the kernel to add MPTCP support so it was easier for me to either
> change the kernel or rebuild the application to force using MPTCP.
>
> > I compiled shadowsocks for android, but is there a similar mptcpize
> > command as below that i can execute in android version?
> >
> > sudo mptcpize enable shadowsocks-libev.service
>
> mptcpize can also be used to launch a specific command, not just SystemD
> services, e.g;
>
>   mptcpize run iperf3 -s
>
> If you launch shadowsocks manually (without the app), I guess you can
> use mptcpize. If not, you might need to modify ShadowSocks to create an
> IPPROTO_MPTCP socket. I'm sure it might be good to send a PR to add
> MPTCP support ;-)
>
> > Any other alternative would also be fine. Can mptcpd daemon make work
> > for android also?
>
> Android is quite specific with many isolated process. I don't think
> mptcpd can be easily integrated :-/
>
> systemtap can also be used to force an application to create MPTCP
> socket but it might not be possible to do that on Android.
> Modifying the app might be the "easiest" (and proper) way.
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

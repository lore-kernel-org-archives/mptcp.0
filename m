Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58014AB5
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 14:28:54 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-579ef51428eso70997377b3.2
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689085733; x=1691677733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HjC/vC09pC8i9pAAm8rEGunT7+wC0x/lLju4IG1YqVc=;
        b=DNOuTw40UfardSUrSJaUf3MEPFHwT0wVe0dZDrdUH9QBcBrCJxAJdrW24iJFarDU3X
         aukfhJaiIyr0FevIWRHwMSbOvba7xjamfZAJZutdcJ7lVRzOYKGC3iNr22r5glG5BdcH
         iPa0rffy/OX6xwZsokEGR3AQxGUAyIOUcuMTyizKt0dLU/03wJx12mN4tKmll8FDWOV7
         WbnVcMeR+Zdnm+6OwHeJGSDkL+MxBMORJeWgvDKvkEH4FzlTupDts5aklvxF4usR5fe8
         ERobtclH+tALI61b3T+G7bZeYHFggN0Sw278+/rSUYTflIuOD4ZR98uIPgjzGFob+9he
         SBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085733; x=1691677733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjC/vC09pC8i9pAAm8rEGunT7+wC0x/lLju4IG1YqVc=;
        b=NXFbYWIGtYjQKTCOHtQ2AOg858sYMT+WPNMazDGtuBLXwPZoNRk4Hz9ZjRjfdk7Y5r
         kUrnR0d4nbF1gDUMAvTKXyovmeYCxb+RUiTcWim5pW36YdP0iP0W/PA7f9IUNqzmoSOY
         U9bqZGGIiUXVBGBGjlJ6Zw+4CNemCPMreNAPB4QiedF0HRNRokrOA1aw+8btD0nIUghn
         koqxRTF6H1tlL9LaoDFpkzISE3chCGmlKfkFDRAl3T5btcjlnoabwQUGDoFzTdUr5IiS
         H2SiGb3PLuzobxEbkr4ZZAAPA/klscRid34fZv57B8YBTj0gUNGmcXbiNQXq6PWGQVCO
         5/qQ==
X-Gm-Message-State: ABy/qLY6ONCfo5kUESgPs2iR/zqTlrTSuea2fpdPOgL5DAzqBh8hF1DL
	UABXZyhdFh+s9paVtBv0t7r/ee4sTlCaZo4191aeMZSRZ64=
X-Google-Smtp-Source: APBJJlFtVY+TWWsyfBA5GW5D/kiaAqYC6alUGTybDbSn/tFPAEsIEiipwGVO7PsX+mqsxZ551aYmVEZ7fUSVEyOs0iA=
X-Received: by 2002:a0d:e645:0:b0:57a:6df7:5ccd with SMTP id
 p66-20020a0de645000000b0057a6df75ccdmr9575054ywe.13.1689085733344; Tue, 11
 Jul 2023 07:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJck1w2+nhbiEsa8+oYvbicruru2nsVbHNMWut1HqGrhZ5nhtw@mail.gmail.com>
 <fdea425d-5a7e-4d85-bcfe-4e624ab25e91@tessares.net> <CAJck1w1pgBQN5RPjXF9crdkcrhN31z0frTwAA8ALk4uzSw0TMQ@mail.gmail.com>
 <b8c5b310-0916-8cec-b5bb-6a2b5b56f218@tessares.net>
In-Reply-To: <b8c5b310-0916-8cec-b5bb-6a2b5b56f218@tessares.net>
From: parthaz lokesh <parthazlokesh@gmail.com>
Date: Tue, 11 Jul 2023 19:58:42 +0530
Message-ID: <CAJck1w0DrZc_9NEi2OA_TYeawWazsuo4iaLF05Ca_tw51gXYHA@mail.gmail.com>
Subject: Re: mptcpize with shadow socks in android
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Matt,

I'm not referring to mptcp flags being dropped by the middle boxes
between client and server.

I'm browsing in applications at server and expecting that packets to
be mptcp. So, connections are initiated at server itself in which
shadowsocks is installed and did mptcpize and checking packet captures
for mptcp packets. But there are no mptcp packets seen in pcaps.

The tutorial ( https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/)
works only for incoming connections but not outgoing connections?

ss -Mape is showing below output. I think shadowsocks can generate
mptcp packets in response to mptcp connection requests. But, it cannot
convert any application's tcp traffic in server to mptcp.

State           Recv-Q          Send-Q                   Local
Address:Port                   Peer Address:Port         Process
LISTEN          0               1024
0.0.0.0:8388                       0.0.0.0:*             uid:25687
ino:49300135 sk:1 cgroup:/system.slice/shadowsocks-libev.service <->
LISTEN          0               1024
[::]:8388                       [::]:*             uid:25687
ino:49300132 sk:2 cgroup:/system.slice/shadowsocks-libev.service
v6only:1 <->

Thanks,
Parthaz.

On Tue, 11 Jul 2023 at 19:35, Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Parthaz,
>
> On 11/07/2023 14:43, parthaz lokesh wrote:
> > However, on the server side, I followed the tutorial from
> > https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/. But,
> > mptcp packets are not seen in pcap. only tcp packets are there.
>
> Do you mean that MPTCP options are dropped between the client and the
> server side?
>
> Some middleboxes (e.g. firewall) can do that. Often by "accident",
> probably a simple configuration option needs to be updated. Most of the
> time, the issue can be fixed if it is reported to the right person.
>
> > Do we
> > have to redirect application traffic to shadowsocks to make MPTCP
> > work? or just below commands should take care of redirection to socks
> > and converting any tcp packets to mptcp packets? If so, it is not
> > working as expected. Could you please guide?
>
> I'm not sure to follow but the server needs to receive a connection
> request with MPTCP options (MP_CAPABLE) to be able to use MPTCP. The
> service handling these connection requests needs to use an MPTCP socket
> (e.g. forced with 'mptcpize').
>
> You can use "ss -Mape" to list all MPTCP sockets opened on your system.
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

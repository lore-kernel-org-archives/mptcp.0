Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227E1BAEF0
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154376; cv=none; b=RVRYrgC2EON4UTOdthr+5MER0me0z/0EslpIQ9juCdTRPv5H/WhRA22/Qyh0PaF+Ph8nSID3b6TIJz27+A49BVZ6UtijzHS6bneoPK1iPo/byCqSl9F5QEBmrpHc/XydDU4unXVxZV1IOB3z4GQ//Wv1P5L8ksGOZs3WF92s7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154376; c=relaxed/simple;
	bh=AyN+ANVQFTnMp5X80VgP5QvvUuU5T0xdI29S2OHwLk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj0zXrgaxqZy2PmqqPNZ6x6rpWEryQEbMJCb3R4XXWmXcOb5KhwJDToJc2PR3nCQPkYGdlMIdvTtqc5Z6VKHKtiOYq6e/RCRTlC2PcPSUOwk7t+BANMDpmqAUY1P5SJ15KyfSG0qDvz7FuP9oHzl+DM/LsW6IYVRxK2KgWULAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.unisi.it; spf=pass smtp.mailfrom=student.unisi.it; dkim=pass (2048-bit key) header.d=student.unisi.it header.i=@student.unisi.it header.b=BkAHQ/z+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.unisi.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.unisi.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=student.unisi.it header.i=@student.unisi.it header.b="BkAHQ/z+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206aee40676so10250405ad.0
        for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.unisi.it; s=google; t=1726154370; x=1726759170; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v0rReUhwoO9avj3WvS1VoAe30OjdZSea9g+ajAajjA0=;
        b=BkAHQ/z+Ice8j13uGt4uxyvX9MyWQLbVvNpUKTtD8eGtqFKZ5xk1KhJ835azCKUOus
         LuTTb1SEcHXmeSO0Ev1SUSELiX6J3ercmaObZQtZHh57IkJozsicrHczfLfmTItnKoy9
         NxG3OveXpKIvUCaPJEgeGUkIxBDN5QYGIZ4Z1H5pOnwXkITZlwsQmK6lLzPZePp6BFgo
         FrJDIujVAjFaRQMRZ90u/bnl2zj4LoHiO9GeVl0wku0f5DG0NO8QyDki04i304XCEGDR
         SL8XuZuJkXEUPxA6o6asLTwJrHBY7lC6OfVKnUT6F+4FyYkNdOabUv0oXxgD0khCHGBI
         HALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154370; x=1726759170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0rReUhwoO9avj3WvS1VoAe30OjdZSea9g+ajAajjA0=;
        b=IIWeL67glzjTrzCmVjo6nJs2WWMobek6y7zKOZb+xToBJNJX3oPVaaO8aWHFpxFiy3
         CK1H9WPhgGo7LYSq3Qb+nDxrPtUPXzOxHjZp8wuvD++tX3NhIJOPZR03mjlBIzfBzCX4
         2VCNPUAinVpyNVvhFpEA+dw+twHHuoXEyxIkBHuOR8QHnSQVtfoOrKI6FLmZlNMKVNvV
         DgXIe3QwSgWEZ4YPPwPwn/NJDQFzUz3rPEi19hsRfpzE4o3eYImbqZT6/s60ph60RJYW
         mywgX1Fqe3u46YnSu2JatmA7XufKuJF15kap++DfQ+1DpBsD/gZve436zZszhAKDfRr0
         f7WQ==
X-Gm-Message-State: AOJu0YxkDnKafmgBWrrPjtXavLJWuNaTdd2inCFYX70UkxMVzWwl9bb4
	5b98jdYKkCpCYKLlLXX72DvkoCjArg8NUvQJXeqGWUG3pPGPKMhy6XIT5N/wgXT9ZDDHTTWcK7a
	l4dQvNfOegRXeHXJwhMb3p7RUidLkeNVnB9/UePO+pGLc/pJMZ+tCNJeh0OGQmz8xLbNs06AmOn
	tKMgL3NOdfktKFXRAW60Hx/c2NQEUejt70Lw==
X-Google-Smtp-Source: AGHT+IHP5eueMVStGSbVlsMY0gWbkjibNwGTth+/zWEcfwOkmZHKsVJ5TX9BOYkHiwzcE5qnm0beuhKZQantKML1Cf8=
X-Received: by 2002:a17:903:1cf:b0:205:6566:cb07 with SMTP id
 d9443c01a7336-2076e34806bmr30295215ad.17.1726154370212; Thu, 12 Sep 2024
 08:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOU6Dw9xnP2ha8Csj47_zQQEHg7_FUrgVRW+CrTon-aPLokKog@mail.gmail.com>
 <45634fda-f0d0-4bc7-99a3-97bb979d0494@kernel.org> <CAOU6Dw9doa_aH8bzLmUxQjFrxn3ThHunDKEzXFmdEcE1w+5CmA@mail.gmail.com>
 <8f355da2-5667-412b-b3fd-1ce8f7571fa8@kernel.org> <CAOU6Dw-P_RRcVJqf2bGY=d8Vsas+H-9Y0tWLRmyTuFxA+5wsMw@mail.gmail.com>
 <CAOU6Dw8j5hhWeXc9dXYW_BKr7WYC-1_-7HfeP31f8vDYhZ5dmg@mail.gmail.com> <023b7d8e-6793-45f8-94b4-51a043d7a114@kernel.org>
In-Reply-To: <023b7d8e-6793-45f8-94b4-51a043d7a114@kernel.org>
From: ROSHITH SEBASTIAN <roshith.sebastian@student.unisi.it>
Date: Thu, 12 Sep 2024 17:19:17 +0200
Message-ID: <CAOU6Dw_hFnE2zY9=m9skt0j5+SWAh7BwKck6HH2jSaOvme97DQ@mail.gmail.com>
Subject: Re: mptcpd Usersapce PM
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Gm-Unisi: student.unisi.it

Hello Matt,

I am able to see that the local and remote addresses are different, my mistake.
Thank you for the explanation regarding the ID.

The issue that I am facing now is that the additional local addresses
associated with the hosts are not getting announced so that subflows
can be created. I tried the codes in both addr_adv and sspi to
understand how to announce the local addresses. On trying to print the
addresses being passed on creating a new connection, the server passes
random IPs (changes on each run) which do not have any interface.

Considering an example with sspi plugin, the mptcpd plugin operation
sspi_new_connection calls sspi_interface_info_lookup which returns
null as the address passed (in below example - 218.91.0.0) to it does
not exist. Hence, the code to inform the kernel about the additional
local addresses is skipped. To add to this, the remote address passed
by the server in the function is 0.0.0.0. I do not understand why a
random IP along with 0.0.0.0, and not the local IP address 192.168.0.2
is passed.

The output from both the client and server are given below:

Client:

h1-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.1  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::fc32:ffff:fe22:ccb4  prefixlen 64  scopeid 0x20<link>
        ether fe:32:ff:22:cc:b4  txqueuelen 1000  (Ethernet)
        RX packets 2208  bytes 166802 (166.8 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2283  bytes 6457403 (6.4 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

h1-eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.0.1  netmask 255.0.0.0  broadcast 192.255.255.255
        inet6 fe80::dc07:48ff:fea3:a0e4  prefixlen 64  scopeid 0x20<link>
        ether de:07:48:a3:a0:e4  txqueuelen 1000  (Ethernet)
        RX packets 14  bytes 1116 (1.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11  bytes 866 (866.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@mpath-VirtualBox:/home/mpath/Python_Projects/MCTestBed# ip mptcp
endpoint show
192.168.0.1 id 1 subflow dev h1-eth1

root@mpath-VirtualBox:/home/mpath/Python_Projects/MCTestBed#
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
/usr/local/libexec/mptcpd -d
configuration.c:mptcpd_config_create() path manager plugin directory:
/usr/local/lib/mpath_plugin
configuration.c:mptcpd_config_create() default path manager plugin: sspi
configuration.c:mptcpd_config_create() address flags: subflow,signal
configuration.c:mptcpd_config_create() notify flags:
existing,skip_link_local,skip_loopback
configuration.c:mptcpd_config_create() plugins to load: sspi
path_manager.c:family_appeared() "mptcp_pm" generic netlink family appeared
path_manager.c:dump_addrs_callback() ID sync: 1 | 192.168.0.1
MPTCP single-subflow-per-interface path manager initialized.
---------New Connection in sspi_new_connection
Address : 10.0.0.1
sspi_connection_established is unimplemented.
---------New Connection in sspi_new_connection
Address : 10.0.0.1
sspi_connection_established is unimplemented.

Server:

h2-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.2  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::b052:ff:fe3b:7c3d  prefixlen 64  scopeid 0x20<link>
        ether b2:52:00:3b:7c:3d  txqueuelen 1000  (Ethernet)
        RX packets 2284  bytes 6457473 (6.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2209  bytes 166872 (166.8 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

h2-eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.0.2  netmask 255.0.0.0  broadcast 192.255.255.255
        inet6 fe80::282d:7bff:fe65:54f0  prefixlen 64  scopeid 0x20<link>
        ether 2a:2d:7b:65:54:f0  txqueuelen 1000  (Ethernet)
        RX packets 12  bytes 936 (936.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 14  bytes 1116 (1.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@mpath-VirtualBox:/home/mpath/Python_Projects/MCTestBed# ip mptcp
endpoint show
192.168.0.2 id 1 signal dev h2-eth1

root@mpath-VirtualBox:/home/mpath/Python_Projects/MCTestBed# LD_LIB
RARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib /usr/local/libexec/mptcpd -d
configuration.c:mptcpd_config_create() path manager plugin directory:
/usr/local/lib/mpath_plugin
configuration.c:mptcpd_config_create() default path manager plugin: sspi
configuration.c:mptcpd_config_create() address flags: subflow,signal
configuration.c:mptcpd_config_create() notify flags:
existing,skip_link_local,skip_loopback
configuration.c:mptcpd_config_create() plugins to load: sspi
path_manager.c:family_appeared() "mptcp_pm" generic netlink family appeared
path_manager.c:dump_addrs_callback() ID sync: 1 | 192.168.0.2
MPTCP single-subflow-per-interface path manager initialized.
Unhandled MPTCP event: 15
---------New Connection in sspi_new_connection
Address : 218.91.0.0
No network interface with given IP address.
Unable to track new connection
sspi_connection_established is unimplemented.
---------New Connection in sspi_new_connection
Address : 218.91.0.0
No network interface with given IP address.
Unable to track new connection
sspi_connection_established is unimplemented.
Untracked connection closed.
Untracked connection closed.

Thanks and Regards,
Roshith Sebastian

On Fri, 6 Sept 2024 at 17:30, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi,
>
> On 06/09/2024 16:58, ROSHITH SEBASTIAN wrote:
> > I have been trying to create a PM using the plugins using the template
> > already present in the page as a starting point.
> > The following code snippet was inserted into the xxx_new_connection
> > and xxx_connection_established functions to identify the remote and
> > local addresses being passed to the function:
> >
> >     struct sockaddr_in *l_addr = (struct sockaddr_in *)laddr;
> >     struct sockaddr_in *r_addr = (struct sockaddr_in *)raddr;
> >     char *l_a = inet_ntoa(l_addr->sin_addr);
> >     char *r_a = inet_ntoa(r_addr->sin_addr);
>
> I don't think your issue is related to mptcpd: inet_ntoa() is
> deprecated, and it is probably causing the issue here. See 'man inet_ntoa':
>
>   The inet_ntoa() function converts the Internet host address in, given
>   in network byte order, to a string in IPv4 dotted-decimal notation.
>   The string is returned in a statically allocated buffer, which
>   **subsequent calls will overwrite**.
>
> (...)
>
> > The function to create a subflow - mptcpd_pm_add_subflow, takes
> > mptcpd_aid_t as a parameter. Can you also please let me know where I
> > can find the documentation to identify which value has to be used
> > here?
>
> You need to provide the local and remote address ID you want to use. 0
> correspond to the addresses of the initial subflow. Apart from this
> special local address, you are free to use any ID with the other address
> you want to use. When establishing a new subflow, each peer shares its
> local address ID. The server can announce address, with an ID. When
> sending a RM_ADDR, the ID corresponds to the local address being
> removed, so the other peer to which address it corresponds.
>
> The concept of ID is explained in more details in the RFC:
>
>
> https://www.rfc-editor.org/rfc/rfc8684.html#name-associating-a-new-subflow-w
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE25CB8
	for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 07:51:32 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-579ef51428eso45363027b3.2
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689580291; x=1692172291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ufXvaUKunUUS8IzmxdnS7RsArWGo7JWtKNuZUtNvlDk=;
        b=T7Y5AUAzPo+d/KsleOOv2bhkhhvIEcr5OritFdhfNsWEe+0WA8ihtLfx0N/xNzm3Rm
         xrovBLw51hhCL00+yjIcSxkALJ1Ib2fKQI5Bntr4giOW1x2i5UKH7vnqiLQ+tY9mumNK
         s1hXhVZoFe8aP8QccDseSoYlvg8Vukq968RseazStIb8CR29yjowalvZm3LX2Yd30sB6
         GgTsLnFCQicDLzYxUUDRqZRWxOMEQJ609RkjtBKe+ieSlugngs1y6ny76VXaxC6osBub
         +sgCbonsvFje+9jN4+sOOkN8LqfHdmFGMmGEbzYzer/oqf76YabL8VWcelQpuaWDJAaL
         tDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580291; x=1692172291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufXvaUKunUUS8IzmxdnS7RsArWGo7JWtKNuZUtNvlDk=;
        b=ZpsOIPalrnU95ZGincd+GhEW6TochTzUS/p17YRHOGmWvZKc0MhQYyZVwS9r3IO6TI
         VZb+ATYWsB7PaXaKR3bfsz36NMbN60oa9zGY5vkdh9QS1iMf1zRGTVwFKoo8egf6Y1se
         Gl28XzXGSOJd8gUR3vbRjD6f1cLg4E6w7/m3gHpP2kgS6AxdXKULPMKzCBBiI97Qhmq4
         KOko07ZqkxoVOYOWeI07g9Uuz9WAHFfgN4qNiP0zsoL+RJzpm8CiILKaNrrePJ54EeAf
         CIVny4x8AC9JZCxtK7rGSc4i1Jg0MAj+ZwmO9IKq93sOUVEDWDtEHbUm77WBREmqW2AI
         eRMQ==
X-Gm-Message-State: ABy/qLbgHi7XKWPRRySoplwzxHwnNvwGZN2XLHF39StjV7WICR/axqcH
	FzbycL3j5Ffl17ghGwMB9oXkpNlybF1WHJcy1RlLGBnBF8E=
X-Google-Smtp-Source: APBJJlFykqakTeP8Q69gVKmJ5nQKn3Sdr90SuxYZGm+nxsINotN1ay3KYqsHHZtrwaYk9z4XnpOrNJLWmO0GzS+ESg0=
X-Received: by 2002:a81:48c2:0:b0:561:d21d:8ce3 with SMTP id
 v185-20020a8148c2000000b00561d21d8ce3mr14769457ywa.3.1689580291306; Mon, 17
 Jul 2023 00:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJck1w2+nhbiEsa8+oYvbicruru2nsVbHNMWut1HqGrhZ5nhtw@mail.gmail.com>
 <fdea425d-5a7e-4d85-bcfe-4e624ab25e91@tessares.net> <CAJck1w1pgBQN5RPjXF9crdkcrhN31z0frTwAA8ALk4uzSw0TMQ@mail.gmail.com>
 <b8c5b310-0916-8cec-b5bb-6a2b5b56f218@tessares.net> <CAJck1w0DrZc_9NEi2OA_TYeawWazsuo4iaLF05Ca_tw51gXYHA@mail.gmail.com>
 <282ef84f-92fe-efb0-7cc9-0b6abe81381c@tessares.net>
In-Reply-To: <282ef84f-92fe-efb0-7cc9-0b6abe81381c@tessares.net>
From: parthaz lokesh <parthazlokesh@gmail.com>
Date: Mon, 17 Jul 2023 13:21:20 +0530
Message-ID: <CAJck1w1Hm8aySg-qE0F6H3FkJMeCC_F8dqK_ce8Po3Dy1OWQOQ@mail.gmail.com>
Subject: Re: mptcpize with shadow socks in android
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000001549400600aa1120"

--0000000000001549400600aa1120
Content-Type: multipart/alternative; boundary="00000000000015493d0600aa111e"

--00000000000015493d0600aa111e
Content-Type: text/plain; charset="UTF-8"

Hello Matt,

Thanks for your feedback. Please find my answers inline below.

OK, then I'm not sure I understood what your setup looks like.
Could you share a small schema please?

In Tessares blog post, I had something like that I think:

> client <-- TCP (SOCKv5) --> proxy client <-- MPTCP (ShadowSocks) -->
proxy server <-- tcp --> end server
So with MPTCP between the proxy client and server. Is it what you have?

If I remember well, redsocks is intercepting connections and create a
SOCKSv5 connection to a SOCKS proxy and I think ss-local can be used to
convert SOCKSv5 to ShadowSocks, no?

>> My configuration is as below. (Attached image as well)
APP (On Android client) ----(TCP Socket)---> Redsocks proxy client(On
Android client) ----(MPTCP Socket)-------> Shadowsocks proxy server (On
ubuntu server) ---(TCP Socket)-----> End content server.
So, I'm redirecting application traffic on android to redsocks proxy where
i'm converting TCP socket to mptcp socket and then sending this traffic to
shadowsocks proxy server. On shadowsocks proxy server, i used mptcpize
commands mentioned in tessares site. This setup is working fine i.e., TCP
packets are converted to MPTCP packets and these packets are reaching the
proxy server.  .

What is the "server" in your case here? The "proxy client"?
>> server means shadowsocks proxy server installed on ubuntu. Currently,
I'm facing the following issues.
1) MPTCP packets which originated from the client are appearing as TCP on
the server. This could be due to mptcp options being dropped by
middleboxes. I'm debugging this.
2) However, my doubt is when I open any application on the server directly
then mptcpize command cannot take care of converting tcp packet to mptcp
packet? Should we redirect app traffic to shadow socks port then only it
can convert TCP to MPTCP?


Also, I'm facing the one more issue at client, To add a second
subflow(Wi-Fi) i'm using below commands. However, mptcp packets are not
seen on the Wi-Fi interface. *Do we have to do anything more to send mptcp
flags on Wi-Fi? *Please note that converting TCP socket to MPTCP socket at
redsocks client is happening for cellular interface only, not for Wi-Fi. I
hope it is enough to do for a single interface!!

ip mptcp limits set subflow 2 add_addr_accepted 2
ip mptcp endpoint add <ip> dev <iface> subflow


Thanks,
Parthaz.


On Tue, 11 Jul 2023 at 20:55, Matthieu Baerts <matthieu.baerts@tessares.net>
wrote:

> On 11/07/2023 16:28, parthaz lokesh wrote:
> > I'm not referring to mptcp flags being dropped by the middle boxes
> > between client and server.
>
> OK, then I'm not sure I understood what your setup looks like.
> Could you share a small schema please?
>
> In Tessares blog post, I had something like that I think:
>
> > client <-- TCP (SOCKv5) --> proxy client <-- MPTCP (ShadowSocks) -->
> proxy server <-- tcp --> end server
> So with MPTCP between the proxy client and server. Is it what you have?
>
> If I remember well, redsocks is intercepting connections and create a
> SOCKSv5 connection to a SOCKS proxy and I think ss-local can be used to
> convert SOCKSv5 to ShadownSocks, no?
>
> > I'm browsing in applications at server and expecting that packets to
> > be mptcp. So, connections are initiated at server itself in which
> > shadowsocks is installed and did mptcpize and checking packet captures
> > for mptcp packets. But there are no mptcp packets seen in pcaps.
>
> What is the "server" in your case here? The "proxy client"?
>
> > The tutorial (
> https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/)
> > works only for incoming connections but not outgoing connections?
>
> If I remember well, I used 'mptcpize' on both the proxy client and proxy
> server. It also means that the proxy client can accept MPTCP connection
> and the proxy server will try to use MPTCP with the end server.
>
> (I don't know if you are here on the proxy client or proxy server host)
>
> > ss -Mape is showing below output. I think shadowsocks can generate
> > mptcp packets in response to mptcp connection requests. But, it cannot
> > convert any application's tcp traffic in server to mptcp.
>
> Yes, here we can see the listening sockets. So yes, it supports incoming
> MPTCP connections. I guess it only creates connections "on the other
> side" when it is needed. So I guess you will need to generate traffic to
> see what it tries to do.
>
> > State           Recv-Q          Send-Q                   Local
> > Address:Port                   Peer Address:Port         Process
> > LISTEN          0               1024
> > 0.0.0.0:8388                       0.0.0.0:*             uid:25687
> > ino:49300135 sk:1 cgroup:/system.slice/shadowsocks-libev.service <->
> > LISTEN          0               1024
> > [::]:8388                       [::]:*             uid:25687
> > ino:49300132 sk:2 cgroup:/system.slice/shadowsocks-libev.service
> > v6only:1 <->
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>

--00000000000015493d0600aa111e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Matt,<br><br>Thanks for your feedback. Please find m=
y answers inline=C2=A0below.<br><br>OK, then I&#39;m not sure I understood =
what your setup looks like.<br>Could you share a small schema please?<br><b=
r>In Tessares blog post, I had something like that I think:<br><br>&gt; cli=
ent &lt;-- TCP (SOCKv5) --&gt; proxy client &lt;-- MPTCP (ShadowSocks) --&g=
t; proxy server &lt;-- tcp --&gt; end server<br>So with MPTCP between the p=
roxy client and server. Is it what you have?<br><br>If I remember well, red=
socks is intercepting connections and create a<br>SOCKSv5 connection to a S=
OCKS proxy and I think ss-local can be used to<br>convert SOCKSv5 to Shadow=
Socks, no?<br><br><font color=3D"#0000ff">&gt;&gt; My configuration is as b=
elow. (Attached image as well)<br>APP (On Android client) ----(TCP Socket)-=
--&gt; Redsocks proxy client(On Android client) ----(MPTCP Socket)-------&g=
t; Shadowsocks proxy server (On ubuntu server) ---(TCP Socket)-----&gt; End=
 content server. <br>So, I&#39;m redirecting application traffic on android=
 to redsocks proxy where i&#39;m converting=C2=A0TCP socket to mptcp socket=
 and then sending this traffic to shadowsocks proxy server. On shadowsocks =
proxy server, i used mptcpize commands mentioned in tessares site. This set=
up is working fine i.e., TCP packets are converted to MPTCP packets and the=
se packets are reaching the proxy server.=C2=A0 .=C2=A0</font><br><br>What =
is the &quot;server&quot; in your case here? The &quot;proxy client&quot;?<=
br><font color=3D"#0000ff">&gt;&gt; server means shadowsocks proxy server i=
nstalled on ubuntu. Currently, I&#39;m facing the following issues. <br>1) =
MPTCP packets which originated from the client are appearing as TCP on the =
server. This could be due to mptcp options being dropped by middleboxes. I&=
#39;m debugging this.=C2=A0<br>2) However, my doubt is when I open any appl=
ication on the server directly then mptcpize command cannot take care of co=
nverting tcp packet to mptcp packet? Should we redirect app traffic to shad=
ow socks port then only it can convert TCP to MPTCP?=C2=A0</font><br><br><b=
r><font color=3D"#0000ff">Also, I&#39;m facing the one more issue at client=
, To add a second subflow(Wi-Fi) i&#39;m using below commands. However, mpt=
cp packets are not seen on the Wi-Fi interface. <u>Do we have to do anythin=
g more to send mptcp flags on Wi-Fi? </u>Please note that converting TCP so=
cket to MPTCP socket at redsocks client is happening for cellular interface=
 only, not for Wi-Fi. I hope it is enough to do for a single interface!!<br=
><br>ip mptcp limits set subflow 2 add_addr_accepted 2<br>ip mptcp endpoint=
 add &lt;ip&gt; dev &lt;iface&gt; subflow</font><br><br><br>Thanks,<br>Part=
haz.</div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, 11 Jul 2023 at 20:55, Matthieu Baerts &lt;<a href=3D"mailto=
:matthieu.baerts@tessares.net">matthieu.baerts@tessares.net</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 11/07/2023 16=
:28, parthaz lokesh wrote:<br>
&gt; I&#39;m not referring to mptcp flags being dropped by the middle boxes=
<br>
&gt; between client and server.<br>
<br>
OK, then I&#39;m not sure I understood what your setup looks like.<br>
Could you share a small schema please?<br>
<br>
In Tessares blog post, I had something like that I think:<br>
<br>
&gt; client &lt;-- TCP (SOCKv5) --&gt; proxy client &lt;-- MPTCP (ShadowSoc=
ks) --&gt; proxy server &lt;-- tcp --&gt; end server<br>
So with MPTCP between the proxy client and server. Is it what you have?<br>
<br>
If I remember well, redsocks is intercepting connections and create a<br>
SOCKSv5 connection to a SOCKS proxy and I think ss-local can be used to<br>
convert SOCKSv5 to ShadownSocks, no?<br>
<br>
&gt; I&#39;m browsing in applications at server and expecting that packets =
to<br>
&gt; be mptcp. So, connections are initiated at server itself in which<br>
&gt; shadowsocks is installed and did mptcpize and checking packet captures=
<br>
&gt; for mptcp packets. But there are no mptcp packets seen in pcaps.<br>
<br>
What is the &quot;server&quot; in your case here? The &quot;proxy client&qu=
ot;?<br>
<br>
&gt; The tutorial ( <a href=3D"https://www.tessares.net/mptcp-proxy-setup-a=
t-home-easier-now/" rel=3D"noreferrer" target=3D"_blank">https://www.tessar=
es.net/mptcp-proxy-setup-at-home-easier-now/</a>)<br>
&gt; works only for incoming connections but not outgoing connections?<br>
<br>
If I remember well, I used &#39;mptcpize&#39; on both the proxy client and =
proxy<br>
server. It also means that the proxy client can accept MPTCP connection<br>
and the proxy server will try to use MPTCP with the end server.<br>
<br>
(I don&#39;t know if you are here on the proxy client or proxy server host)=
<br>
<br>
&gt; ss -Mape is showing below output. I think shadowsocks can generate<br>
&gt; mptcp packets in response to mptcp connection requests. But, it cannot=
<br>
&gt; convert any application&#39;s tcp traffic in server to mptcp.<br>
<br>
Yes, here we can see the listening sockets. So yes, it supports incoming<br=
>
MPTCP connections. I guess it only creates connections &quot;on the other<b=
r>
side&quot; when it is needed. So I guess you will need to generate traffic =
to<br>
see what it tries to do.<br>
<br>
&gt; State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Recv-Q=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Send-Q=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Local<br>
&gt; Address:Port=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Peer Address:Port=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Process<br>
&gt; LISTEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A01024<br>
&gt; <a href=3D"http://0.0.0.0:8388" rel=3D"noreferrer" target=3D"_blank">0=
.0.0.0:8388</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00.0.0.0:*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uid:25687<br>
&gt; ino:49300135 sk:1 cgroup:/system.slice/shadowsocks-libev.service &lt;-=
&gt;<br>
&gt; LISTEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A01024<br>
&gt; [::]:8388=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[::]:*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uid:25687<br>
&gt; ino:49300132 sk:2 cgroup:/system.slice/shadowsocks-libev.service<br>
&gt; v6only:1 &lt;-&gt;<br>
<br>
Cheers,<br>
Matt<br>
-- <br>
Tessares | Belgium | Hybrid Access Solutions<br>
<a href=3D"http://www.tessares.net" rel=3D"noreferrer" target=3D"_blank">ww=
w.tessares.net</a><br>
</blockquote></div>

--00000000000015493d0600aa111e--
--0000000000001549400600aa1120
Content-Type: image/png; name="config.PNG"
Content-Disposition: attachment; filename="config.PNG"
Content-Transfer-Encoding: base64
Content-ID: <f_lk6jmsrc1>
X-Attachment-Id: f_lk6jmsrc1

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
+l+Zn23ArBNNPwAAAABJRU5ErkJggg==
--0000000000001549400600aa1120--

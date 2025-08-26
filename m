Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6C1F8723
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756181457; cv=none; b=J8+7wokomU7V9zoot3qgVuNFpQXeVJ04u+UloL0EmoPM8V+WHLhqiWblxg9FVuTFpfihsz8VYC2vll7Sm206q3lE5rhb1+fINPvSOfc4ZCj1dFNM/T241mm1KR+FC19EXS0fPXNn/fJ1S14ouJ7DvZNlCx2jxp7ilCXWhEpvBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756181457; c=relaxed/simple;
	bh=IT7t5SKAIk1sdW4y3HVQJMGwoVB2uH6bOAgMNDUq7UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc5ojGFxxMYPGVuuAZey4m0pP7c+lrHlMQTVgKkc46XJHNTbGFVNYxbYgUsL2w/rcYpOmhVwwixEjzIG/HmvP3vFIhi1hWV/cMTn2+zs7cERJ5RTRnHnEcOa8K+waCLzRf83jgpUKvBUA+eHYZ+8NICpgG4TzefXPq5oK56/+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=JN3XIm4j; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="JN3XIm4j"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-33670e8c975so13978331fa.3
        for <mptcp@lists.linux.dev>; Mon, 25 Aug 2025 21:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756181452; x=1756786252; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7QDIgUDvRnUuNex6i+pH+f1LxqLu35cj8ki4+PmX4Q=;
        b=JN3XIm4jGze6+Xtv2GZyw2Q4rV5ga0TP22MPDlgMcOWuaPvRsyU6jabBQO5nYezjTX
         iD4qCjhK8UUbNW4PpxFQiNx5fvmWwJvPS1oFtnYS9Q4QNlKhpq79CuY1s/mS8ZNVfBi9
         EuLFy0gX+q2qGq5hyEY3GUUXHbu1HYA9YkTjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756181452; x=1756786252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7QDIgUDvRnUuNex6i+pH+f1LxqLu35cj8ki4+PmX4Q=;
        b=ixmd2oAaNAbfahu9Vb5RwNtF+d/pVUdQ3GM4dAuF1o7DiMXZ9KNCK6/UiCSgsgXnxR
         Hrpa/1rbysG/Ym8Ut/+i4L57H+kNtt1uJwTSl215FhjMD/J0qhiJ73k548+pWnscFbjp
         WAAGoFP/hiQka0GHZY8frh9mXDqikai+gVJfiH4SPsYlPPDDxYy1/9fxa6EDQ0RERKPp
         0jTD7/4KfJw03INdGHH1ufN4wvr1NRocJP1LoWErE/gXX6W/2RPWqysiqls+QlSlZHbj
         WdNo03dMi4yqvH6cE38O6kcDJstiBl9W+p8rV1X4jwRNq+MCs+0rN79HhtbCL2VZeqm8
         +JTA==
X-Gm-Message-State: AOJu0YyCv3XB2EmhrHUH7gq2ULpRoj3jVrBeiIj2nynkXEwlfHOdE8I4
	MSBH5URs0sjbVD5uULHvvrl+wnbdpwnQbIYZdWDiQQWaDBpAbZ/M8JNDnDQ9JPf8o3vwherUtkP
	JV4yxDdQi8W0NoIdLDWJoCNNRWdbYFbNDPZ6PAb5AIA==
X-Gm-Gg: ASbGncu/+3BrmPLOOUc0pHQniIkGSky9vnjC5a0AehMYta9nbqgV+a/KYLUP7CpWi8z
	9uXwf+/4jHtH+hYUksC/sjcpwLhQS1fjlQohygeILBHoai/Idv16Pl2F7IllhKmd65vFb9HeoEq
	wGRwNEbwxG4AAGxtv/EQWVg45+MYafvY3sL9OzvRu23fTNSQqmX1refUrGbeq3Gk5gsWRLlAxj2
	pNqzsOYczaNWkBIU3ywIMA293J42kMpVqi58Lfl5zLSnJyLq7v7
X-Google-Smtp-Source: AGHT+IEYI8xEHzwu2u0J6lrlqF9hB1ycEuQ9QjPoqTrqGUk7kgVpAmMKmaqT/Ol/eN/iGwejzhEwYbamS6kJi6dZi6Q=
X-Received: by 2002:a2e:be11:0:b0:336:853d:27fe with SMTP id
 38308e7fff4ca-336853d30bamr4412421fa.6.1756181452421; Mon, 25 Aug 2025
 21:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com>
 <2f037b38-c9f4-44a0-857c-0f65cbd50688@kernel.org> <CADg4-L9YE8guQWz1xDovoyyHrb723WaurRoeWJZ5P+J=OVrRDg@mail.gmail.com>
 <4d933d54-fff1-4a9d-9601-753b8cddf934@kernel.org> <3decc4cd-bbf1-45f1-9985-d2b795c5bfcc@kernel.org>
In-Reply-To: <3decc4cd-bbf1-45f1-9985-d2b795c5bfcc@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 25 Aug 2025 21:10:41 -0700
X-Gm-Features: Ac12FXwlcaM-hdGhdwf6O9IxmhUOWRK3UN5b0lkqKAt9r-IOdb8iN-E6hwXeT0Y
Message-ID: <CADg4-L8FGZXf+Mo-VukEuNzjoVLupcGMch7dZd-dN5J1wBB1XQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] mptcp: record subflows in RPS table
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang@kernel.org>, 
	Mat Martineau <martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:47=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Christoph,
>
> On 14/08/2025 13:20, Matthieu Baerts wrote:
> > Hi Christoph,
> >
> > On 14/08/2025 05:31, Christoph Paasch wrote:
> >> On Wed, Aug 13, 2025 at 7:54=E2=80=AFAM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> >>>
> >>> Hi Christoph,
> >>>
> >>> On 07/08/2025 20:14, Christoph Paasch via B4 Relay wrote:
> >>>> From: Christoph Paasch <cpaasch@openai.com>
> >>>>
> >>>> Accelerated Receive Flow Steering (aRFS) relies on sockets recording
> >>>> their RX flow hash into the rps_sock_flow_table so that incoming pac=
kets
> >>>> are steered to the CPU where the application runs.
> >>>>
> >>>> With MPTCP, the application interacts with the parent MPTCP socket w=
hile
> >>>> data is carried over per-subflow TCP sockets. Without recording thes=
e
> >>>> subflows, aRFS cannot steer interrupts and RX processing for the flo=
ws
> >>>> to the desired CPU.
> >>>>
> >>>> Record all subflows in the RPS table by calling sock_rps_record_flow=
()
> >>>> for each subflow at the start of mptcp_sendmsg() and mptcp_recvmsg()=
.
> >>>>
> >>>> It does not by itself improve throughput, but ensures that IRQ and R=
X
> >>>> processing are directed to the right CPU, which is a
> >>>> prerequisite for effective aRFS.
> >>>
> >>> Thank you for looking at that!
> >>>
> >>>> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> >>>> ---
> >>>>  net/mptcp/protocol.c | 16 ++++++++++++++++
> >>>>  1 file changed, 16 insertions(+)
> >>>>
> >>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >>>> index 4b510e04724f5c8be08a00a1cc03093bcd031905..86f1fc5be47bd5f6dc8b=
f40a488de32f253c1beb 100644
> >>>> --- a/net/mptcp/protocol.c
> >>>> +++ b/net/mptcp/protocol.c
> >>>> @@ -12,6 +12,7 @@
> >>>>  #include <linux/sched/signal.h>
> >>>>  #include <linux/atomic.h>
> >>>>  #include <net/aligned_data.h>
> >>>> +#include <net/rps.h>
> >>>>  #include <net/sock.h>
> >>>>  #include <net/inet_common.h>
> >>>>  #include <net/inet_hashtables.h>
> >>>> @@ -1740,6 +1741,17 @@ static u32 mptcp_send_limit(const struct sock=
 *sk)
> >>>>       return limit - not_sent;
> >>>>  }
> >>>>
> >>>> +static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
> >>>> +{
> >>>> +     struct mptcp_subflow_context *subflow;
> >>>> +
> >>>> +     mptcp_for_each_subflow(msk, subflow) {
> >>>> +             struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> >>>> +
> >>>> +             sock_rps_record_flow(ssk);
> >>>
> >>> Should we eventually open code this RPS function and directly call
> >>> sock_rps_record_flow_hash()? If RPS is not needed, no need to go thro=
ugh
> >>> the subflow list. So we could add: #ifdef CONFIG_RPS + &rfs_needed
> >>> before the for_each, then check the state for each subflow, no?
> >>>
> >>> Or maybe such optimisation is not worth it?
> >>
> >> IMO it's not worth it. Because it would also mean that we pull in more
> >> of non-MPTCP things over to MPTCP files.
> >
> > Good point for the maintenance!
> >
> > But then, what about adding a small helper in include/net/rps.h? Here w=
e
> > could have this at the top of mptcp_rps_record_subflows():
> >
> >   if (!sock_rps_record_needed())   /* with likely()? */
> >       return;
> >
> > I'm suggesting this because rfs is disabled by default, so it sounds
> > better to check that before iterating over different subflows for
> > nothing, no?

I see! Yes, that may be a good addition. I am doing that.

> >>> While at it, I see that sock_rps_record_flow() is called in
> >>> __inet_accept(), inet(6)_sendmsg and inet(6)_recvmsg, but with the ms=
k.
> >>> I guess that's OK, right?
> >>
> >> AFAICS, that should be alright. sk_rxhash should not be set on an msk.
> >> Even on the passive opener side, we clone msk from the ssk, but at
> >> that point sk_rxhash is not set yet. (I may be wrong of course, I'm
> >> still not super familiar with the source-code...)
> >
> > Thank you for having looked! I guess you would have seen issues when
> > testing if there was a problem with that, so no need to investigate mor=
e.
> >
> >>> Also, is sock_rps_record_flow() called when a subflow is "accept()ed"=
,
> >>> or is there something else to do there for this subflow to copy TCP's
> >>> behaviour?
> >>
> >> For new subflows, I don't think we can easily do that. Because
> >> sock_rps_record_flow() records the CPU on which it is running. From
> >> what I see, when new subflows get accepted, that is not happening in
> >> the application's context necessarily. So, we have to wait for a
> >> recvmsg/sendmsg.
> >
> > Ah yes, of course, we should not do it there for additional subflows!
> > And for the first subflow, I think that it will be done because when an
> > accept() is triggered from the userspace, mptcp_stream_accept(msk, arg)
> > will call inet_csk_accept(ssk, arg) that will end up doing that I think=
.
>
> My bad, I think __inet_accept will not be called from inet_csk_accept().
> For TCP, I think the path is:
>
>   inet_accept()
>     --> inet_csk_accept()
>     --> __inet_accept()
>
> But with MPTCP, mptcp_stream_accept is called instead of inet_accept(),
> and I don't think __inet_accept() will be called on a subflow. (I didn't
> validate that.) Then, maybe we should call sock_rps_record_flow() on the
> newsk in mptcp_stream_accept, no?

Indeed! I will iterate over the subflows there as well and take care of the=
m.


Christoph

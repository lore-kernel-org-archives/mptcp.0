Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAF4298994
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397575; cv=none; b=SPt0FbpGj6jhV10AtMRvxrTF4Mt4tdIG3xTi8Au3iZNQm3U7tX4EM9YAMf0YmBlnEVIMRQ1L6ixcBVMXfgoiq6kTOFGGZiQ6KGOilFKfpsxPi0ATESjE1Qzr0gF3H5qSlije+HpSHiSrtQSkRKvdnLuZl+XIibJodmFrG5B3Sfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397575; c=relaxed/simple;
	bh=4B2eJw1KpiYme0YPN/U/4sST30EYcOA/PKrK8BjlP2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgznZtlCtXMVWIw6ihRzDU4BiQKDWE1KnrbNxkWcIPzELPuqIYtL7J8rRkATSGuAdM8iJe6X8EKO6gdWVZKmH4Zd3F/4A538vGmPMDpTPwLrN6CH/rjCtD009HT0FhqtaYJcx6QrFrXtFx4dip6/E1B5Vjsch+WXdDl3J0IsRzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=NdmEYcNy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="NdmEYcNy"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-336a73cb9ddso5770311fa.1
        for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756397572; x=1757002372; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzmOcn89CaW2l5U7vqEPxzkV+D1BuPsU6i7VsNSaD64=;
        b=NdmEYcNyZywNUEfCu0mwwBz0OMWmjUScB8fTNSRg2+8mokZritYgBGElMpw2ZJLMpZ
         0qwv4yYAWGul460t4lwENpZ6N6hAjBh/ISY20k5ist/ehcuRTthJJ8dHgU5T+c5YufQv
         KYq8hQr0JKcMCGl6uo0eh+LVFMWpqu8Im0tRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397572; x=1757002372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzmOcn89CaW2l5U7vqEPxzkV+D1BuPsU6i7VsNSaD64=;
        b=Ro1CVRd498uFbfvDDa+9Aj98AkzEYlXCxzr+x/oIX9QIvOg7AdaLkz21KOcoaO19GU
         U62wpK48RBTeoS7NhgDHyeexIVoQaXHx3ITYHVV4FgOHQU5oi4dv9o60AfAM488BCSLM
         U5O2jkLD+yTMsRAYwJQV/attESmGgB6jeaAaf9lkAUdi00zXKE0Gf5DyDUu/N04cNuZz
         fVIuL6B9hk/NYuGQT5IFQQB840nM5VYqJQt8fB9brfSZb3uF1LEJFKbrOmKwkVIbb2Jt
         xlXbXzINmEi0AlWz3z3vTebSo4sfVVaVMRkUiabDSm5cBqyNXS5RYujHUN168EcesGtc
         o+9w==
X-Gm-Message-State: AOJu0YxB4PgF69mJA5AGO1SG54GBuieDaQbDa+dGr6mfAZEFp/ut2cI+
	Vbp4cjAj9GVgfrwukZ1aZbKbNjI+r6KQBTNDiSGifsbW+qEa4a+srkeua0l7uhysdBZI4wrEJD5
	IUWl4ScYVBsKunoJzzQC2z6xJfEOHRPSah1HoAxyi1bzbXAbGywUIBG8=
X-Gm-Gg: ASbGncsjhA4Ig715YX7a/mUguPHudip279XFeMOjQhemIuNOTF76WQqfowrLv5ey9fj
	jP2FKkrPqJOXvGg+7dkkkiU5IPHSxF6yE+fO85HhmVup4mJcJqgt1WW082NzpvqFdok25rZCiig
	f/NiQftuoh1J/kT5YZgAv2qVyrJz0WL74e3noY7zKjsDRSs1fUelShGvdym6sAlf1uWKcvghcvS
	mQQxnETv/oppHon/inIii+Zdnywfm02w2bvIqOPZSp8FK3Y4z9l1tmzHH+hqSEWIRp6vEeTYQ==
X-Google-Smtp-Source: AGHT+IHD2M4hrAPQnypYMHtmTikzEUCsYJ7in/1o/7Ue9lwQDgsQ3QGq3EUtYjsOzwCvnu4lvx5BofDrMbm02vv9gQE=
X-Received: by 2002:a2e:a9a9:0:b0:32b:4773:7a80 with SMTP id
 38308e7fff4ca-33650f3e3c5mr70292961fa.25.1756397571512; Thu, 28 Aug 2025
 09:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250825-b4-mptcp_perf-v2-0-5d2d68dfa8af@openai.com>
 <20250825-b4-mptcp_perf-v2-2-5d2d68dfa8af@openai.com> <c4c9247d-f1a3-4b2a-8a9a-600e151f6124@kernel.org>
In-Reply-To: <c4c9247d-f1a3-4b2a-8a9a-600e151f6124@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 28 Aug 2025 09:12:40 -0700
X-Gm-Features: Ac12FXy5cA4r7hZkz1ABmk8iVey1h7KmyFSbidFVfAVpZVDQUJPGeckqgb2Vl48
Message-ID: <CADg4-L_+4+e57PFhCTqZBVSg=Y6DW6suK9HSxGUvYfvRXYob3w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: record subflows in RPS table
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:50=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Christoph,
>
> On 26/08/2025 06:30, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > Accelerated Receive Flow Steering (aRFS) relies on sockets recording
> > their RX flow hash into the rps_sock_flow_table so that incoming packet=
s
> > are steered to the CPU where the application runs.
> >
> > With MPTCP, the application interacts with the parent MPTCP socket whil=
e
> > data is carried over per-subflow TCP sockets. Without recording these
> > subflows, aRFS cannot steer interrupts and RX processing for the flows
> > to the desired CPU.
> >
> > Record all subflows in the RPS table by calling sock_rps_record_flow()
> > for each subflow at the start of mptcp_sendmsg(), mptcp_recvmsg() and
> > mptcp_stream_accept(), by using the new helper
> > mptcp_rps_record_subflows().
> >
> > It does not by itself improve throughput, but ensures that IRQ and RX
> > processing are directed to the right CPU, which is a
> > prerequisite for effective aRFS.
>
> Thank you for the v2! I just have two small questions below, but I don't
> think they are blocking.
>
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >  net/mptcp/protocol.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4b510e04724f5c8be08a00a1cc03093bcd031905..543506b6a011af782083818=
57ab9c1962cbc6636 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/atomic.h>
> >  #include <net/aligned_data.h>
> > +#include <net/rps.h>
> >  #include <net/sock.h>
> >  #include <net/inet_common.h>
> >  #include <net/inet_hashtables.h>
> > @@ -1740,6 +1741,20 @@ static u32 mptcp_send_limit(const struct sock *s=
k)
> >       return limit - not_sent;
> >  }
> >
> > +static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
> > +{
> > +     struct mptcp_subflow_context *subflow;
> > +
> > +     if (!rfs_is_needed())
> > +             return;
> > +
> > +     mptcp_for_each_subflow(msk, subflow) {
> > +             struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > +
> > +             sock_rps_record_flow(ssk);
>
> I guess we don't want to call _sock_rps_record_flow() here to avoid
> calling rfs_is_needed() multiple times in a row, because it is just an
> extra static branch check?

IMO, the _sock_rps_* functions are not meant to be called  from
outside rps.h. They are just in the rps.h file so that they can be
static inline.
In any case, the _sock_rps_* functions are guarded by #ifdef CONFIG_RPS.

> > +     }
> > +}
> > +
> >  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t l=
en)
> >  {
> >       struct mptcp_sock *msk =3D mptcp_sk(sk);
> > @@ -1753,6 +1768,8 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
> >
> >       lock_sock(sk);
> >
> > +     mptcp_rps_record_subflows(msk);
> > +
> >       if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
> >                    msg->msg_flags & MSG_FASTOPEN)) {
> >               int copied_syn =3D 0;
> > @@ -2131,6 +2148,8 @@ static int mptcp_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
> >               goto out_err;
> >       }
> >
> > +     mptcp_rps_record_subflows(msk);
> > +
> >       timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> >
> >       len =3D min_t(size_t, len, INT_MAX);
> > @@ -3921,6 +3940,8 @@ static int mptcp_stream_accept(struct socket *soc=
k, struct socket *newsock,
> >                               mptcp_sock_graft(ssk, newsock);
> >               }
> >
> > +             mptcp_rps_record_subflows(msk);
>
> Out of curiosity, why not calling sock_rps_record_flow(ssk) here?

Again, primarily to keep the code clean. MPTCP-code calls
mptcp_rps_record_subflows, which calls sock_rps_record_flow() which
calls the _sock_rps helpers. In my opinion that is a better structure
and flow.
No real pure technical reason.


Christoph

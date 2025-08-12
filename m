Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6442E1C74
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990417; cv=none; b=dqTGMuvW5EHP9+mRkcrVDcxGLmWcqSffCX8Oi6BWEdjQuCVBEw2HhaKDsq6gY4HpU5EeVByW9x0kvZ59PycXCiLBg3JNMipXJ1wOpbexL5pl6nqM17Ro2/OQQ5uAxfhPRhBqISgyuuoyXo9VHMk627Rg51LGGuakxb0bfpn+jCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990417; c=relaxed/simple;
	bh=HRWBhV82lu5JR9mGQB5nZOkfBlRJt5tUN2CSLawjIqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FNMfjonOy+fc8mcOJ5GK++NSNYbhwS1WpZ2CmRQztQZpoTRn0/cAeUEqakNjg72DZ4wN3wlBEUeajak65pspmWMYytqbR8L9JeQDDLjMciqhYZUoIh+dEdGznlALVz3IHjGvT/ZENY4k+hiXtk6NJx6F8bXgV9kVb8My+gWC9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMNVnaPW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMNVnaPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467E8C4CEF0;
	Tue, 12 Aug 2025 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754990416;
	bh=HRWBhV82lu5JR9mGQB5nZOkfBlRJt5tUN2CSLawjIqU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sMNVnaPW8tvPuFZskD+CP8gbo8z1D4eUL1on60c4bL0PWzqcrSd5hR/C9DJcWUKTY
	 bfZ+mXkW9+H3wJ1eJkVuMQTvLPNXag4c41ene0OETboRcBNPaw9VZ/xXDR9u/bZoNB
	 32iHtas4EZ+kOlrXdF/55/HaKVWRWzW4L2/rpwFJcpIGbca5nkYkPVI0UEeeO26WV8
	 iq1pl68wf+eU4caCJSb1OWBsEfix3g2r1U5S32Td2GTHwwMaJl9SwnwWyMEu2VMM4w
	 TH1+mU/3rOWSJToOy4dzbu/jRLE+LWuRaDki4zRZjBZWUBnyjNcAwkk1YdvSYothAF
	 TyybkmsQrXnxA==
Message-ID: <2c6f89d333cb88760c566f85f843b6fa56b00152.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: make ADD_ADDR retransmission
 timeout adaptive
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Christoph Paasch
 <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 12 Aug 2025 17:20:09 +0800
In-Reply-To: <1e636ef3-6756-4638-89ab-2a013df9454a@kernel.org>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
	 <c559f29eea1e019b6d25a35f05bbeb85fdd578e1.1754449947.git.tanggeliang@kylinos.cn>
	 <eb6c0e4d-938c-4712-83b2-ee12bd70aa12@kernel.org>
	 <f42defcb7fe7db02283fed5def29623cbc6a24d7.camel@kernel.org>
	 <b0a4ebe8-0dfd-4c15-89bf-98c4f7cfebc0@kernel.org>
	 <78799855faff1bb19cdec5210ca5edf302d39974.camel@kernel.org>
	 <5d4dfa60-7604-4b45-becf-8df8bd0667ed@kernel.org>
	 <CADg4-L8iLwmp6GCscWCq9vwPTyavgi54i5KSjLPneULQHvwB9Q@mail.gmail.com>
	 <1e636ef3-6756-4638-89ab-2a013df9454a@kernel.org>
Content-Type: multipart/mixed; boundary="=-txY6Nv8SckR4Apci0TXQ"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

--=-txY6Nv8SckR4Apci0TXQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Matt, Christoph,

On Tue, 2025-08-12 at 10:39 +0200, Matthieu Baerts wrote:
> Hi Christoph,
> 
> On 11/08/2025 17:34, Christoph Paasch wrote:
> > On Mon, Aug 11, 2025 at 7:51 AM Matthieu Baerts
> > <matttbe@kernel.org> wrote:
> > > 
> > > Hi Geliang,
> > > 
> > > On 10/08/2025 03:13, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > On Thu, 2025-08-07 at 13:56 +0200, Matthieu Baerts wrote:
> > > > > Hi Geliang,
> > > > > 
> > > > > On 07/08/2025 05:25, Geliang Tang wrote:
> > > > > > Hi Matt,
> > > > > > 
> > > > > > On Wed, 2025-08-06 at 17:34 +0200, Matthieu Baerts wrote:
> > > > > > > Hi Geliang,
> > > > > > > 
> > > > > > > On 06/08/2025 05:17, Geliang Tang wrote:
> > > > > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > > > > 
> > > > > > > > Replace the fixed ADD_ADDR retransmission timeout with
> > > > > > > > an
> > > > > > > > adaptive
> > > > > > > > mechanism that uses the maximum RTO among existing
> > > > > > > > subflows.
> > > > > > > > This
> > > > > > > > improves responsiveness when establishing new subflows
> > > > > > > > while
> > > > > > > > maintaining
> > > > > > > > an upper bound through the configured add_addr_timeout
> > > > > > > > value.
> > > > > > > > 
> > > > > > > > Key changes:
> > > > > > > > 1. Compute timeout as min(max_subflow_RTO,
> > > > > > > > configured_max_timeout)
> > > > > > > > 2. Apply exponential backoff based on retransmission
> > > > > > > > count
> > > > > > > > 3. Maintain fallback to configured max timeout when no
> > > > > > > > subflows
> > > > > > > > exist
> > > > > > > > 4. Update documentation to clarify add_addr_timeout is
> > > > > > > > now the
> > > > > > > > maximum
> > > > > > > > value
> > > > > > > > 
> > > > > > > > Closes:
> > > > > > > > https://github.com/multipath-tcp/mptcp_net-next/issues/576
> > > > > > > > Reviewed-by: Christoph Paasch <cpaasch@openai.com>
> > > > > > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > > > > ---
> > > > > > > >  Documentation/networking/mptcp-sysctl.rst |  4 +--
> > > > > > > >  net/mptcp/pm.c                            | 30
> > > > > > > > ++++++++++++++++++++---
> > > > > > > >  2 files changed, 29 insertions(+), 5 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/Documentation/networking/mptcp-sysctl.rst
> > > > > > > > b/Documentation/networking/mptcp-sysctl.rst
> > > > > > > > index 1683c139821e..2b8e8fb99ee2 100644
> > > > > > > > --- a/Documentation/networking/mptcp-sysctl.rst
> > > > > > > > +++ b/Documentation/networking/mptcp-sysctl.rst
> > > > > > > > @@ -8,8 +8,8 @@ MPTCP Sysfs variables
> > > > > > > >  ===============================
> > > > > > > > 
> > > > > > > >  add_addr_timeout - INTEGER (seconds)
> > > > > > > > - Set the timeout after which an ADD_ADDR control
> > > > > > > > message
> > > > > > > > will be
> > > > > > > > - resent to an MPTCP peer that has not acknowledged a
> > > > > > > > previous
> > > > > > > > + Set the maximum value of timeout after which an
> > > > > > > > ADD_ADDR
> > > > > > > > control message
> > > > > > > > + will be resent to an MPTCP peer that has not
> > > > > > > > acknowledged
> > > > > > > > a previous
> > > > > > > >   ADD_ADDR message.
> > > > > > > > 
> > > > > > > >   Do not retransmit if set to 0.
> > > > > > > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > > > > > > index 1330af6a2154..34cc4f45bc7d 100644
> > > > > > > > --- a/net/mptcp/pm.c
> > > > > > > > +++ b/net/mptcp/pm.c
> > > > > > > > @@ -268,6 +268,30 @@ int
> > > > > > > > mptcp_pm_mp_prio_send_ack(struct
> > > > > > > > mptcp_sock *msk,
> > > > > > > >   return -EINVAL;
> > > > > > > >  }
> > > > > > > > 
> > > > > > > > +static unsigned int
> > > > > > > > mptcp_adjust_add_addr_timeout(struct
> > > > > > > > mptcp_sock *msk)
> > > > > > > > +{
> > > > > > > > + struct mptcp_subflow_context *subflow;
> > > > > > > > + struct sock *sk = (struct sock *)msk;
> > > > > > > > + unsigned int max_rto = 0;
> > > > > > > > + unsigned int timeout;
> > > > > > > > +
> > > > > > > > + timeout = mptcp_get_add_addr_timeout(sock_net(sk));
> > > > > > > > +
> > > > > > > > + mptcp_for_each_subflow(msk, subflow) {
> > > > > > > > +         struct sock *ssk =
> > > > > > > > mptcp_subflow_tcp_sock(subflow);
> > > > > > > > +         unsigned int subflow_rto;
> > > > > > > > +
> > > > > > > > +         subflow_rto = __tcp_set_rto(tcp_sk(ssk)) * 2;
> > > > > > > 
> > > > > > > Why "* 2"? Is it what TCP is doing?
> > > > > > > 
> > > > > > > (Probably best to add a comment here above, and in the
> > > > > > > commit
> > > > > > > message.)
> > > > > > > 
> > > > > > > (Also, I guess the compiler will do the optimisation, but
> > > > > > > you
> > > > > > > could
> > > > > > > write: ">> 1" instead of "* 2".
> > > > > > 
> > > > > > Yes, "<< 1" is much better. I added a comment here:
> > > > > > 
> > > > > > +               /*
> > > > > > +                * icsk->icsk_rto is not used directly
> > > > > > since
> > > > > > +                * it's not updated frequently enough.
> > > > > > +                *
> > > > > > +                * subflow_rto is twice of rto, and allow
> > > > > > +                * some tolerance for add_addr echo.
> > > > > > +                */
> > > > > > +               subflow_rto = __tcp_set_rto(tcp_sk(ssk)) <<
> > > > > > 1;
> > > > > > 
> > > > > > Is this okay?
> > > > > 
> > > > > No :)
> > > > > 
> > > > > I don't think the comment explain why it is twice the default
> > > > > TCP
> > > > > RTO.
> > > > > Why having an exception here for the ADD_ADDR? I mean: I'm OK
> > > > > with
> > > > > the
> > > > > idea of doubling the RTO, but only if there is a reason
> > > > > behind that
> > > > > :)
> > > > 
> > > > How about this one (answered by DeepSeek, an AI from China):
> > > > 
> > > >         /*
> > > >          * icsk->icsk_rto is not used directly since it's not
> > > >          * updated frequently enough.
> > > 
> > > What about: (...) since it might not have been updated recently.
> > > 
> > > >          * Setting subflow_rto to twice of RTO provides a
> > > > safety
> > > >          * buffer for RTT estimation variance, kernel RTO
> > > > update
> > > >          * delays, and a full transmission retry cycle while
> > > >          * minimizing false failures.
> > > 
> > > A bit long and not clear (typical AI, making commit messages too
> > > verbose, it almost force me to use one to give me the summary :)
> > > )
> > > 
> > > What about:
> > > 
> > >   Setting this RTO to twice of TCP one, not to be too agressive
> > > for this
> > >   notification that might take longer to process than "simple"
> > > data.
> > > 
> > > Still, is icsk_rto not already "long" enough by default? I mean:
> > > when I
> > > see your description in the related packetdrill PR [1] where the
> > > delay
> > > is supposed to be 0.01 sec, but "subflow_rto" (or was it
> > > isck_rto?) is
> > > 0.65 sec, that's quite different, and half of it would be more
> > > than
> > > enough :)
> > > 
> > > But maybe that's different when it happens later during the
> > > connection?
> > 
> > Why wouldn't icsk_rto not be good enough ? We just need a
> > reasonable
> > number here.
> 
> I didn't have time to investigate in between, but is icsk_rto not
> updated only when needed (@Geliang: did you check?). So could it be
> possible that at the beginning of the connection, the value is not
> correct?
> 
> If yes, why not using __tcp_set_rto()?
> 
> > And, I must say that 2 x __tcp_set_rto() seems a bit
> > arbitrary. Let's just use icsk_rto. Does it really matter that it
> > is
> > not updated very frequently ?
> 
> Maybe yes.
> 
> @Geliang: but before sending a new version, please check my comment:
> 
>   https://github.com/multipath-tcp/packetdrill/pull/166
> 
> Especially this part:
> 
> > 0.65s looks a lot to me: The 3rd ACK at line 15 should be injected
> > with a delay of 0.01s.
> > 
> > What are the values of icsk->icsk_rto, tp->srtt_us, tp->rttvar_us,
> > __tcp_set_rto(tp) and the one you set for the timer when scheduling
> > each retransmissions and when running this test?
> > 
> > (for the rto value in jiffies, please convert them to usec like the
> > others → jiffies_to_usecs())
> 
> Sharing such info when running the packetdrill tests using a non
> debug
> kernel (and ideally also sharing the output of packetdrill, when
> running
> it with the extra -vvvv), would help better understand the situation
> here.

Here is the debug patch based on v4:

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0497a7d2446e..1f203c279620 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -271,6 +271,12 @@ static unsigned int
mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
        mptcp_for_each_subflow(msk, subflow) {
                struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
                struct inet_connection_sock *icsk = inet_csk(ssk);
+               struct tcp_sock *tp = tcp_sk(ssk);
+
+               pr_info("icsk->icsk_rto=%uus, __tcp_set_rto(tp)=%uus,
tp->srtt_us=%uus, tp->rttvar_us=%uus",
+                       jiffies_to_usecs(icsk->icsk_rto),
+                       jiffies_to_usecs(__tcp_set_rto(tp)),
+                       tp->srtt_us, tp->rttvar_us);
 
                if (icsk->icsk_rto > max)
                        max = icsk->icsk_rto;
@@ -319,9 +325,14 @@ static void mptcp_pm_add_timer(struct timer_list
*timer)
                entry->retrans_times++;
        }
 
-       if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+       if (entry->retrans_times < ADD_ADDR_RETRANS_MAX) {
+               pr_info("retrans_times=%u add_addr_timeout=%uus\n",
+                       entry->retrans_times,
+                       jiffies_to_usecs(timeout << entry-
>retrans_times));
+
                sk_reset_timer(sk, timer,
                               jiffies + (timeout << entry-
>retrans_times));
+       }
 
        spin_unlock_bh(&msk->pm.lock);
 
And here is the log:

OK   [/opt/packetdrill/gtests/net/mptcp/add_addr/add_addr6_server.pkt
(ipv6)]
[  374.343386] MPTCP: icsk->icsk_rto=211000us,
__tcp_set_rto(tp)=211000us, tp->srtt_us=83640us, tp->rttvar_us=200000us
[  374.343396] MPTCP: retrans_times=1 add_addr_timeout=422000us
[  374.343695] MPTCP: icsk->icsk_rto=211000us,
__tcp_set_rto(tp)=211000us, tp->srtt_us=83520us, tp->rttvar_us=200000us
[  374.343696] MPTCP: retrans_times=1 add_addr_timeout=422000us
[  374.351277] MPTCP: icsk->icsk_rto=211000us,
__tcp_set_rto(tp)=211000us, tp->srtt_us=81064us, tp->rttvar_us=200000us
[  374.351280] MPTCP: retrans_times=1 add_addr_timeout=422000us
[  374.359279] MPTCP: icsk->icsk_rto=211000us,
__tcp_set_rto(tp)=211000us, tp->srtt_us=83416us, tp->rttvar_us=200000us
[  374.359280] MPTCP: retrans_times=1 add_addr_timeout=422000us
[  374.362808] MPTCP: icsk->icsk_rto=433000us,
__tcp_set_rto(tp)=433000us, tp->srtt_us=1121560us, tp-
>rttvar_us=291850us
[  374.362907] MPTCP: icsk->icsk_rto=312000us,
__tcp_set_rto(tp)=312000us, tp->srtt_us=827589us, tp-
>rttvar_us=207860us
[  374.367273] MPTCP: icsk->icsk_rto=211000us,
__tcp_set_rto(tp)=211000us, tp->srtt_us=80728us, tp->rttvar_us=200000us
[  374.367324] MPTCP: retrans_times=1 add_addr_timeout=422000us
FAIL
[/opt/packetdrill/gtests/net/mptcp/add_addr/add_addr_retry_plain.pkt
(ipv4)]
stdout: 
stderr: 
add_addr_retry_plain.pkt:22: error handling packet: timing error:
expected outbound packet at 1.164616 sec but happened at 0.382298 sec;
tolerance 0.400000 sec
script packet:  1.164616 . 1:1(0) ack 1 <add_address address_id: 1
ipv4: 192.168.0.2 hmac: 18072054855919674796>
actual packet:  0.382298 . 1:1(0) ack 1 win 1050 <add_address
address_id: 1 ipv4: 192.168.0.2 hmac: 18072054855919674796>

Full log is attached.

In this test, __tcp_set_rto(tp) is the same as icsk->icsk_rto.

Thanks,
-Geliang

> 
> Cheers,
> Matt

--=-txY6Nv8SckR4Apci0TXQ
Content-Disposition: attachment; filename="add_addr_timeout.log"
Content-Transfer-Encoding: base64
Content-Type: text/x-log; name="add_addr_timeout.log"; charset="UTF-8"

cm9vdEBtcHRjcGRldjovb3B0L3BhY2tldGRyaWxsL2d0ZXN0cy9uZXQjIC4vcGFja2V0ZHJpbGwv
cnVuX2FsbC5weSAtbHYgbXB0Y3AvYWRkX2FkZHIvICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgClsgIDE2NC4wMjMyNzRdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0zMTAwMDB1cywgX190
Y3Bfc2V0X3J0byh0cCk9MzEwMDAwdXMsIHRwLT5zcnR0X3VzPTgyNjQ1NnVzLCB0cC0+cnR0dmFy
X3VzPTIwNjYxNHVzClsgIDM3Mi4zMjQ3MjRdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTIwMDB1
cywgX190Y3Bfc2V0X3J0byh0cCk9MjEyMDAwdXMsIHRwLT5zcnR0X3VzPTk1NTIwdXMsIHRwLT5y
dHR2YXJfdXM9MjAwMDAwdXMKWyAgMzcyLjMzNDY3Nl0gTVBUQ1A6IGljc2stPmljc2tfcnRvPTIx
MTAwMHVzLCBfX3RjcF9zZXRfcnRvKHRwKT0yMTEwMDB1cywgdHAtPnNydHRfdXM9ODE1NTJ1cywg
dHAtPnJ0dHZhcl91cz0yMDAwMDB1cwpbICAzNzIuMzQ5NzYxXSBNUFRDUDogaWNzay0+aWNza19y
dG89MjEyMDAwdXMsIF9fdGNwX3NldF9ydG8odHApPTIxMjAwMHVzLCB0cC0+c3J0dF91cz05MDgx
NnVzLCB0cC0+cnR0dmFyX3VzPTIwMDAwMHVzCk9LICAgWy9vcHQvcGFja2V0ZHJpbGwvZ3Rlc3Rz
L25ldC9tcHRjcC9hZGRfYWRkci9hZGRfYWRkcjRfY2xpZW50LnBrdCAoaXB2NCldCk9LICAgWy9v
cHQvcGFja2V0ZHJpbGwvZ3Rlc3RzL25ldC9tcHRjcC9hZGRfYWRkci9hZGRfYWRkcjRfcG9ydF9j
bGllbnQucGt0IChpcHY0KV0KT0sgICBbL29wdC9wYWNrZXRkcmlsbC9ndGVzdHMvbmV0L21wdGNw
L2FkZF9hZGRyL2FkZF9hZGRyNF9zZXJ2ZXIucGt0IChpcHY2KV0KT0sgICBbL29wdC9wYWNrZXRk
cmlsbC9ndGVzdHMvbmV0L21wdGNwL2FkZF9hZGRyL2FkZF9hZGRyNF9jbGllbnQucGt0IChpcHY0
LW1hcHBlZC12NildCk9LICAgWy9vcHQvcGFja2V0ZHJpbGwvZ3Rlc3RzL25ldC9tcHRjcC9hZGRf
YWRkci9hZGRfYWRkcjRfcG9ydF9jbGllbnQucGt0IChpcHY0LW1hcHBlZC12NildCk9LICAgWy9v
cHQvcGFja2V0ZHJpbGwvZ3Rlc3RzL25ldC9tcHRjcC9hZGRfYWRkci9hZGRfYWRkcjRfc2VydmVy
LnBrdCAoaXB2NCldClsgIDM3My4wNjIwMjldIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTIwMDB1
cywgX190Y3Bfc2V0X3J0byh0cCk9MjEyMDAwdXMsIHRwLT5zcnR0X3VzPTkzMDI0dXMsIHRwLT5y
dHR2YXJfdXM9MjAwMDAwdXMKT0sgICBbL29wdC9wYWNrZXRkcmlsbC9ndGVzdHMvbmV0L21wdGNw
L2FkZF9hZGRyL2FkZF9hZGRyNF9jbGllbnQucGt0IChpcHY2KV0KT0sgICBbL29wdC9wYWNrZXRk
cmlsbC9ndGVzdHMvbmV0L21wdGNwL2FkZF9hZGRyL2FkZF9hZGRyNF9zZXJ2ZXIucGt0IChpcHY0
LW1hcHBlZC12NildCk9LICAgWy9vcHQvcGFja2V0ZHJpbGwvZ3Rlc3RzL25ldC9tcHRjcC9hZGRf
YWRkci9hZGRfYWRkcjRfcG9ydF9jbGllbnQucGt0IChpcHY2KV0KT0sgICBbL29wdC9wYWNrZXRk
cmlsbC9ndGVzdHMvbmV0L21wdGNwL2FkZF9hZGRyL2FkZF9hZGRyNl9jbGllbnQucGt0IChpcHY0
KV0KWyAgMzczLjMwMzgyNl0gTVBUQ1A6IGljc2stPmljc2tfcnRvPTIxMTAwMHVzLCBfX3RjcF9z
ZXRfcnRvKHRwKT0yMTEwMDB1cywgdHAtPnNydHRfdXM9ODU1Mjh1cywgdHAtPnJ0dHZhcl91cz0y
MDAwMDB1cwpPSyAgIFsvb3B0L3BhY2tldGRyaWxsL2d0ZXN0cy9uZXQvbXB0Y3AvYWRkX2FkZHIv
YWRkX2FkZHI2X2NsaWVudC5wa3QgKGlwdjQtbWFwcGVkLXY2KV0KT0sgICBbL29wdC9wYWNrZXRk
cmlsbC9ndGVzdHMvbmV0L21wdGNwL2FkZF9hZGRyL2FkZF9hZGRyNl9wb3J0X2NsaWVudC5wa3Qg
KGlwdjQpXQpPSyAgIFsvb3B0L3BhY2tldGRyaWxsL2d0ZXN0cy9uZXQvbXB0Y3AvYWRkX2FkZHIv
YWRkX2FkZHI2X3BvcnRfY2xpZW50LnBrdCAoaXB2NildCk9LICAgWy9vcHQvcGFja2V0ZHJpbGwv
Z3Rlc3RzL25ldC9tcHRjcC9hZGRfYWRkci9hZGRfYWRkcjZfc2VydmVyLnBrdCAoaXB2NC1tYXBw
ZWQtdjYpXQpbICAzNzMuNzI2MzQxXSBNUFRDUDogaWNzay0+aWNza19ydG89MjExMDAwdXMsIF9f
dGNwX3NldF9ydG8odHApPTIxMTAwMHVzLCB0cC0+c3J0dF91cz04Mjg1NnVzLCB0cC0+cnR0dmFy
X3VzPTIwMDAwMHVzCk9LICAgWy9vcHQvcGFja2V0ZHJpbGwvZ3Rlc3RzL25ldC9tcHRjcC9hZGRf
YWRkci9hZGRfYWRkcjZfY2xpZW50LnBrdCAoaXB2NildCk9LICAgWy9vcHQvcGFja2V0ZHJpbGwv
Z3Rlc3RzL25ldC9tcHRjcC9hZGRfYWRkci9hZGRfYWRkcjZfc2VydmVyLnBrdCAoaXB2NCldClsg
IDM3My45Nzc1MDhdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1cywgX190Y3Bfc2V0X3J0
byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgxODk2dXMsIHRwLT5ydHR2YXJfdXM9MjAwMDAw
dXMKWyAgMzc0LjEyNTY2M10gTVBUQ1A6IGljc2stPmljc2tfcnRvPTIxMTAwMHVzLCBfX3RjcF9z
ZXRfcnRvKHRwKT0yMTEwMDB1cywgdHAtPnNydHRfdXM9ODM1MjB1cywgdHAtPnJ0dHZhcl91cz0y
MDAwMDB1cwpbICAzNzQuMTI1NzM3XSBNUFRDUDogaWNzay0+aWNza19ydG89MjExMDAwdXMsIF9f
dGNwX3NldF9ydG8odHApPTIxMTAwMHVzLCB0cC0+c3J0dF91cz04MzY0MHVzLCB0cC0+cnR0dmFy
X3VzPTIwMDAwMHVzClsgIDM3NC4xMzI5MTddIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1
cywgX190Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgxMDY0dXMsIHRwLT5y
dHR2YXJfdXM9MjAwMDAwdXMKWyAgMzc0LjE0MjUyNl0gTVBUQ1A6IGljc2stPmljc2tfcnRvPTIx
MTAwMHVzLCBfX3RjcF9zZXRfcnRvKHRwKT0yMTEwMDB1cywgdHAtPnNydHRfdXM9ODM0MTZ1cywg
dHAtPnJ0dHZhcl91cz0yMDAwMDB1cwpPSyAgIFsvb3B0L3BhY2tldGRyaWxsL2d0ZXN0cy9uZXQv
bXB0Y3AvYWRkX2FkZHIvYWRkX2FkZHI2X3BvcnRfY2xpZW50LnBrdCAoaXB2NC1tYXBwZWQtdjYp
XQpbICAzNzQuMTU0NTEwXSBNUFRDUDogaWNzay0+aWNza19ydG89MjExMDAwdXMsIF9fdGNwX3Nl
dF9ydG8odHApPTIxMTAwMHVzLCB0cC0+c3J0dF91cz04MDcyOHVzLCB0cC0+cnR0dmFyX3VzPTIw
MDAwMHVzClsgIDM3NC4xOTEyODBdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1cywgX190
Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgxODk2dXMsIHRwLT5ydHR2YXJf
dXM9MjAwMDAwdXMKWyAgMzc0LjE5MTUzN10gTVBUQ1A6IHJldHJhbnNfdGltZXM9MSBhZGRfYWRk
cl90aW1lb3V0PTQyMjAwMHVzCk9LICAgWy9vcHQvcGFja2V0ZHJpbGwvZ3Rlc3RzL25ldC9tcHRj
cC9hZGRfYWRkci9hZGRfYWRkcjZfc2VydmVyLnBrdCAoaXB2NildClsgIDM3NC4zNDMzODZdIE1Q
VENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMs
IHRwLT5zcnR0X3VzPTgzNjQwdXMsIHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMKWyAgMzc0LjM0MzM5
Nl0gTVBUQ1A6IHJldHJhbnNfdGltZXM9MSBhZGRfYWRkcl90aW1lb3V0PTQyMjAwMHVzClsgIDM3
NC4zNDM2OTVdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1cywgX190Y3Bfc2V0X3J0byh0
cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgzNTIwdXMsIHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMK
WyAgMzc0LjM0MzY5Nl0gTVBUQ1A6IHJldHJhbnNfdGltZXM9MSBhZGRfYWRkcl90aW1lb3V0PTQy
MjAwMHVzClsgIDM3NC4zNTEyNzddIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1cywgX190
Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgxMDY0dXMsIHRwLT5ydHR2YXJf
dXM9MjAwMDAwdXMKWyAgMzc0LjM1MTI4MF0gTVBUQ1A6IHJldHJhbnNfdGltZXM9MSBhZGRfYWRk
cl90aW1lb3V0PTQyMjAwMHVzClsgIDM3NC4zNTkyNzldIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0y
MTEwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgzNDE2dXMs
IHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMKWyAgMzc0LjM1OTI4MF0gTVBUQ1A6IHJldHJhbnNfdGlt
ZXM9MSBhZGRfYWRkcl90aW1lb3V0PTQyMjAwMHVzClsgIDM3NC4zNjI4MDhdIE1QVENQOiBpY3Nr
LT5pY3NrX3J0bz00MzMwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9NDMzMDAwdXMsIHRwLT5zcnR0
X3VzPTExMjE1NjB1cywgdHAtPnJ0dHZhcl91cz0yOTE4NTB1cwpbICAzNzQuMzYyOTA3XSBNUFRD
UDogaWNzay0+aWNza19ydG89MzEyMDAwdXMsIF9fdGNwX3NldF9ydG8odHApPTMxMjAwMHVzLCB0
cC0+c3J0dF91cz04Mjc1ODl1cywgdHAtPnJ0dHZhcl91cz0yMDc4NjB1cwpbICAzNzQuMzY3Mjcz
XSBNUFRDUDogaWNzay0+aWNza19ydG89MjExMDAwdXMsIF9fdGNwX3NldF9ydG8odHApPTIxMTAw
MHVzLCB0cC0+c3J0dF91cz04MDcyOHVzLCB0cC0+cnR0dmFyX3VzPTIwMDAwMHVzClsgIDM3NC4z
NjczMjRdIE1QVENQOiByZXRyYW5zX3RpbWVzPTEgYWRkX2FkZHJfdGltZW91dD00MjIwMDB1cwpG
QUlMIFsvb3B0L3BhY2tldGRyaWxsL2d0ZXN0cy9uZXQvbXB0Y3AvYWRkX2FkZHIvYWRkX2FkZHJf
cmV0cnlfcGxhaW4ucGt0IChpcHY0KV0Kc3Rkb3V0OiAKc3RkZXJyOiAKYWRkX2FkZHJfcmV0cnlf
cGxhaW4ucGt0OjIyOiBlcnJvciBoYW5kbGluZyBwYWNrZXQ6IHRpbWluZyBlcnJvcjogZXhwZWN0
ZWQgb3V0Ym91bmQgcGFja2V0IGF0IDEuMTY0NjE2IHNlYyBidXQgaGFwcGVuZWQgYXQgMC4zODIy
OTggc2VjOyB0b2xlcmFuY2UgMC40MDAwMDAgc2VjCnNjcmlwdCBwYWNrZXQ6ICAxLjE2NDYxNiAu
IDE6MSgwKSBhY2sgMSA8YWRkX2FkZHJlc3MgYWRkcmVzc19pZDogMSBpcHY0OiAxOTIuMTY4LjAu
MiBobWFjOiAxODA3MjA1NDg1NTkxOTY3NDc5Nj4KYWN0dWFsIHBhY2tldDogIDAuMzgyMjk4IC4g
MToxKDApIGFjayAxIHdpbiAxMDUwIDxhZGRfYWRkcmVzcyBhZGRyZXNzX2lkOiAxIGlwdjQ6IDE5
Mi4xNjguMC4yIGhtYWM6IDE4MDcyMDU0ODU1OTE5Njc0Nzk2PgpGQUlMIFsvb3B0L3BhY2tldGRy
aWxsL2d0ZXN0cy9uZXQvbXB0Y3AvYWRkX2FkZHIvYWRkX2FkZHJfcmV0cnlfcGxhaW4ucGt0IChp
cHY0LW1hcHBlZC12NildCnN0ZG91dDogCnN0ZGVycjogCmFkZF9hZGRyX3JldHJ5X3BsYWluLnBr
dDoyMjogZXJyb3IgaGFuZGxpbmcgcGFja2V0OiB0aW1pbmcgZXJyb3I6IGV4cGVjdGVkIG91dGJv
dW5kIHBhY2tldCBhdCAxLjE2NDYwMiBzZWMgYnV0IGhhcHBlbmVkIGF0IDAuMzgyNDEyIHNlYzsg
dG9sZXJhbmNlIDAuNDAwMDAwIHNlYwpzY3JpcHQgcGFja2V0OiAgMS4xNjQ2MDIgLiAxOjEoMCkg
YWNrIDEgPGFkZF9hZGRyZXNzIGFkZHJlc3NfaWQ6IDEgaXB2NDogMTkyLjE2OC4wLjIgaG1hYzog
MTAzOTY1MjgyNDMzOTYxNjg5MjA+CmFjdHVhbCBwYWNrZXQ6ICAwLjM4MjQxMiAuIDE6MSgwKSBh
Y2sgMSB3aW4gMTA1MCA8YWRkX2FkZHJlc3MgYWRkcmVzc19pZDogMSBpcHY0OiAxOTIuMTY4LjAu
MiBobWFjOiAxMDM5NjUyODI0MzM5NjE2ODkyMD4KRkFJTCBbL29wdC9wYWNrZXRkcmlsbC9ndGVz
dHMvbmV0L21wdGNwL2FkZF9hZGRyL2FkZF9hZGRyX3JldHJ5X3BsYWluLnBrdCAoaXB2NildCnN0
ZG91dDogCnN0ZGVycjogCmFkZF9hZGRyX3JldHJ5X3BsYWluLnBrdDoyMjogZXJyb3IgaGFuZGxp
bmcgcGFja2V0OiB0aW1pbmcgZXJyb3I6IGV4cGVjdGVkIG91dGJvdW5kIHBhY2tldCBhdCAxLjA4
MzE2MyBzZWMgYnV0IGhhcHBlbmVkIGF0IDAuMjk1ODg4IHNlYzsgdG9sZXJhbmNlIDAuNDAwMDAw
IHNlYwpzY3JpcHQgcGFja2V0OiAgMS4wODMxNjMgLiAxOjEoMCkgYWNrIDEgPGFkZF9hZGRyZXNz
IGFkZHJlc3NfaWQ6IDEgaXB2NjogZmQzZDphMGI6MTdkNjo6MiBobWFjOiAxNTMzNjg2MzY5MzIw
NDg0NzE4Nj4KYWN0dWFsIHBhY2tldDogIDAuMjk1ODg4IC4gMToxKDApIGFjayAxIHdpbiAxMDUw
IDxhZGRfYWRkcmVzcyBhZGRyZXNzX2lkOiAxIGlwdjY6IGZkM2Q6YTBiOjE3ZDY6OjIgaG1hYzog
MTUzMzY4NjM2OTMyMDQ4NDcxODY+ClsgIDM3NC42MTU0MDVdIE1QVENQOiBpY3NrLT5pY3NrX3J0
bz0yMTEwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgxODk2
dXMsIHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMKWyAgMzc0LjYxNTQxNF0gTVBUQ1A6IHJldHJhbnNf
dGltZXM9MiBhZGRfYWRkcl90aW1lb3V0PTg0NDAwMHVzClsgIDM3NC42OTMyOThdIE1QVENQOiBp
Y3NrLT5pY3NrX3J0bz0zMDIwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9MzAyMDAwdXMsIHRwLT5z
cnR0X3VzPTgwMzMyNHVzLCB0cC0+cnR0dmFyX3VzPTIwMDkxMnVzClsgIDM3NC43NjcyOTddIE1Q
VENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMs
IHRwLT5zcnR0X3VzPTgzNTIwdXMsIHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMKWyAgMzc0Ljc2NzQ4
OV0gTVBUQ1A6IHJldHJhbnNfdGltZXM9MiBhZGRfYWRkcl90aW1lb3V0PTg0NDAwMHVzClsgIDM3
NC43Njc2NThdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1cywgX190Y3Bfc2V0X3J0byh0
cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgzNjQwdXMsIHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMK
WyAgMzc0Ljc2NzY1OV0gTVBUQ1A6IHJldHJhbnNfdGltZXM9MiBhZGRfYWRkcl90aW1lb3V0PTg0
NDAwMHVzClsgIDM3NC43NzUzOThdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0yMTEwMDB1cywgX190
Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgxMDY0dXMsIHRwLT5ydHR2YXJf
dXM9MjAwMDAwdXMKWyAgMzc0Ljc3NTQwNl0gTVBUQ1A6IHJldHJhbnNfdGltZXM9MiBhZGRfYWRk
cl90aW1lb3V0PTg0NDAwMHVzClsgIDM3NC43ODMyODFdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0y
MTEwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgzNDE2dXMs
IHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMKWyAgMzc0Ljc4MzI4M10gTVBUQ1A6IHJldHJhbnNfdGlt
ZXM9MiBhZGRfYWRkcl90aW1lb3V0PTg0NDAwMHVzClsgIDM3NC43OTEyODJdIE1QVENQOiBpY3Nr
LT5pY3NrX3J0bz0yMTEwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0
X3VzPTgwNzI4dXMsIHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMKWyAgMzc0Ljc5MTI4Nl0gTVBUQ1A6
IHJldHJhbnNfdGltZXM9MiBhZGRfYWRkcl90aW1lb3V0PTg0NDAwMHVzCk9LICAgWy9vcHQvcGFj
a2V0ZHJpbGwvZ3Rlc3RzL25ldC9tcHRjcC9hZGRfYWRkci9hZGRfYWRkcl9lY2hvX25ld19zZi5w
a3QgKGlwdjQpXQpPSyAgIFsvb3B0L3BhY2tldGRyaWxsL2d0ZXN0cy9uZXQvbXB0Y3AvYWRkX2Fk
ZHIvYWRkX2FkZHJfZWNob19uZXdfc2YucGt0IChpcHY0LW1hcHBlZC12NildCk9LICAgWy9vcHQv
cGFja2V0ZHJpbGwvZ3Rlc3RzL25ldC9tcHRjcC9hZGRfYWRkci9hZGRfYWRkcl9lY2hvX25ld19z
Zi5wa3QgKGlwdjYpXQpbICAzNzUuNjcxNTE4XSBNUFRDUDogaWNzay0+aWNza19ydG89MjExMDAw
dXMsIF9fdGNwX3NldF9ydG8odHApPTIxMTAwMHVzLCB0cC0+c3J0dF91cz04MDcyOHVzLCB0cC0+
cnR0dmFyX3VzPTIwMDAwMHVzClsgIDM3NS42NzE1MzVdIE1QVENQOiBpY3NrLT5pY3NrX3J0bz0y
MTEwMDB1cywgX190Y3Bfc2V0X3J0byh0cCk9MjExMDAwdXMsIHRwLT5zcnR0X3VzPTgzNjQwdXMs
IHRwLT5ydHR2YXJfdXM9MjAwMDAwdXMKT0sgICBbL29wdC9wYWNrZXRkcmlsbC9ndGVzdHMvbmV0
L21wdGNwL2FkZF9hZGRyL2FkZF9hZGRyX3JldHJ5X2Vycm9ycy5wa3QgKGlwdjQpXQpPSyAgIFsv
b3B0L3BhY2tldGRyaWxsL2d0ZXN0cy9uZXQvbXB0Y3AvYWRkX2FkZHIvYWRkX2FkZHJfcmV0cnlf
ZXJyb3JzLnBrdCAoaXB2NC1tYXBwZWQtdjYpXQpPSyAgIFsvb3B0L3BhY2tldGRyaWxsL2d0ZXN0
cy9uZXQvbXB0Y3AvYWRkX2FkZHIvYWRkX2FkZHJfcmV0cnlfZXJyb3JzLnBrdCAoaXB2NildClJh
biAgIDI3IHRlc3RzOiAgIDI0IHBhc3NpbmcsICAgIDMgZmFpbGluZywgICAgMCB0aW1lZCBvdXQg
KDUuNDEgc2VjKTogbXB0Y3AvYWRkX2FkZHIvCg==


--=-txY6Nv8SckR4Apci0TXQ--

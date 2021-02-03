Content-Type: multipart/mixed; boundary="===============1306023063141425254=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [bug report] the test cases for signaling invalid
 addresses don't work
Date: Wed, 03 Feb 2021 18:24:04 +0100
Message-ID: <30e490d065f6181ca058f2ba3f5f0b9ef98e2b7b.camel@redhat.com>
In-Reply-To: CA+WQbwuPyd6cMTZgxfZVtoDR-aaNkgRYNzA_dFe9oyjRxSoqVA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7611

--===============1306023063141425254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-02-03 at 19:30 +0800, Geliang Tang wrote:
> I added two test cases for signaling multi addresses today:
> =

>          # signal addresses
>          reset
>          ip netns exec $ns1 ./pm_nl_ctl limits 3 3
>          ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
>          ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
>          ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
>          ip netns exec $ns2 ./pm_nl_ctl limits 3 3
>          run_tests $ns1 $ns2 10.0.1.1
>          chk_join_nr "signal addresses" 3 3 3
>          chk_add_nr 3 3
> =

>          # signal invalid addresses
>          reset
>          ip netns exec $ns1 ./pm_nl_ctl limits 3 3
>          ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
>          ip netns exec $ns1 ./pm_nl_ctl add 10.0.13.1 flags signal
>          ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
>          ip netns exec $ns2 ./pm_nl_ctl limits 3 3
>          run_tests $ns1 $ns2 10.0.1.1
>          chk_join_nr "signal invalid addresses" 0 0 0
>          chk_add_nr 1 1
> =

> The 1st one works well, the 2nd one added three invalid addresses, but
> only got 1 ADD_ADDR and 1 ECHO. I thought it should be 0 ADD_ADDR or
> 3 ADD_ADDRs.
> =

> In the 2nd test case, mptcp_pm_create_subflow_or_signal_addr was only
> triggered once when the msk is established. Since the first address is an
> invalid one, the subflow for it cannot be created successfully. So
> mptcp_pm_nl_subflow_established could not be invoked. The last two
> addresses didn't have a chance to be announced. I think this behavior is
> incorrect.
> =

> I have several questions about this:
> =

> 1. Is this an known issue? Is it worth creating a new issue on github and
> fixing it?

I think filing a github issue is the correct thing to do, so that we
don't lose track of this in the ML. =


Even if I must admit it looks a low prio item to me.

> 2. What do we expect for the 2nd test case, 0 ADD_ADDR or 3 ADD_ADDRs?
> 3. Should we skip announcing the invalid addresses?
> 4. Or should we change the logic of mptcp_pm_create_subflow_or_signal_addr
> to announce all the invalid addresses?

I think the "correct" behaviour would be announcing 3 addresses.
Setting and maintaining correct list of addresses is up to the user-
space/path-manger.

The kernel could teorerically watch out for local IP address changes,
but even announcing only IPs that are locally available would not
guarantee the related subflow to be established - for a gazilion of
reasons, last but not least the address could be removed by the admin
after being announced and before subflow creation.

Overall I think the kernel should not filter the addresses to be
annonced in any way.

Eventually we could change how add_addr events are scheduled, e.g.
moving to the next address after that the previous one has been echoed
by the peer.

As I said I think it's not an huge priority, we have planty of bugs to
fix first ;) So I would just keep the current result, possibly adding a
TODO/FIXME note in the test and/or in the relevant kernel code.

All the above IMHO.

Cheers,

Paolo

--===============1306023063141425254==--

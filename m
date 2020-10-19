Content-Type: multipart/mixed; boundary="===============8601817319094335009=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/1] Squash to "selftests:
 mptcp: add ADD_ADDR timeout test case" with IPv6 and skip
Date: Mon, 19 Oct 2020 18:43:24 +0200
Message-ID: <b9b6077d622866b01655c95bbed08209d4dff0bb.camel@redhat.com>
In-Reply-To: c7b4a479-4e2f-55c5-5c50-6d87249c5068@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6354

--===============8601817319094335009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-19 at 18:08 +0200, Matthieu Baerts wrote:
> On 19/10/2020 13:26, Geliang Tang wrote:
> > @@ -509,12 +530,16 @@ chk_add_nr 1 1
> >   =

> >   # add_addr timeout
> >   reset_with_add_addr_timeout
> > -ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > -ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > -ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > -run_tests $ns1 $ns2 10.0.1.1 0 0 slow
> > -chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
> > -chk_add_nr 4 0
> > +if [ $? -eq 0 ]; then
> > +	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> > +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> > +	run_tests $ns1 $ns2 10.0.1.1 0 0 slow
> > +	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
> > +	chk_add_nr 4 0
> > +else
> > +	echo "signal address, ADD_ADDR timeout SKIP: without iptables tool"
> =

> Should we add this?
> =

>    ret=3D${ksft_skip}
> =

> In this case, people would notice one test has been skipped but would =

> still have results for the other ones (if an "exit" is not added).
> =

> Or maybe better by adding this?
> =

>    # no other errors: exit with "SKIP" status not to ignore this message
>    if [ ${ret} -eq 0 ]; then
>            ret=3D${ksft_skip}
>    fi
> =

> WDYT?
> =

> @Paolo: at the last meeting, you mentioned you were going to think about =

> that, that's why I added you in cc :-)

looking at the current net self-tests status, 'ksft_skip' usage is a
bit fuzzy. I think the only scenarios where it's exposed reliably to
the caller is a selftest script baling out due to missing command (and
skipping all the test-cases). =


Additionally I likely overlooked at the 'missing iptables' situation -
as a compatiblity layer is available.

So overall I think we could stick to the simpler scenario and just
bailing out on start-up if iptables is missing, as in Matthieu's patch
- I'm sorry for changing my mind, I had to look this better...

/P=20

--===============8601817319094335009==--

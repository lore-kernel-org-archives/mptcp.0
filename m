Content-Type: multipart/mixed; boundary="===============8228680610996226412=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: insonsistend subflow creation policy ?!?
Date: Wed, 17 Feb 2021 12:12:15 -0800
Message-ID: <ab2b81a-794f-fc89-3b94-1d102811999a@linux.intel.com>
In-Reply-To: 1f2bbfaba037c836d7c718eb6ac1aa8266ec83a0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7834

--===============8228680610996226412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Feb 2021, Paolo Abeni wrote:

> Hello,
>
> I just noted that the pm_netlink subflow creation policy is
> inconsistent (or perhaps simply different ?!?) between signal and
> add_addr subflows.
>
> When the MPTCP socket tries to create additional subflow due an
> 'subflow' endpoint, it will filter out local addresses already in use
> by existing subflow.
>
> When MPTCP tries to create an additional subflow due to an incoming
> 'ADD_ADDR' option, it will try to create it regardless any existing
> subflow using the relevant remote address (and port).
>
> Should we change the above ?!? (e.g. applying some filters even for
> ADD_ADDR). Or perhpas add some additional policy flag (like 'unique' or
> 'none') ?
>
> WDYT?
>

I think the same filters should apply for ADD_ADDR - we should not be more =

permissive to requests from the peer than we are with local requests. =

Given that we don't allow a lot of subflows, it seems better to avoid =

using up the available subflows for duplicate paths.

--
Mat Martineau
Intel
--===============8228680610996226412==--

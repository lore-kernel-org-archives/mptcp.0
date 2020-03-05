Content-Type: multipart/mixed; boundary="===============8802949246081988639=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/12] pm netlink: followup and fixes
Date: Wed, 04 Mar 2020 17:02:37 -0800
Message-ID: <alpine.OSX.2.22.394.2003041632410.33439@mlee22-mobl.amr.corp.intel.com>
In-Reply-To: d26beb71fd0c5b5469b4ec3c3b31d5639805f4e3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3866

--===============8802949246081988639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2020, Paolo Abeni wrote:

> On Wed, 2020-03-04 at 16:01 +0100, Paolo Abeni wrote:
>> Note: mp join self tests are still unstable, e.g. can fail randomly, due=
 to an
>> old race between mptcp_token_update_accept() and mptcp_token_get_sock():=
 e.g.
>> a client may legitly try to create a subflow after that the first one is=
 fully
>> established but before the server has accepted the initial socket:
>> mptcp_token_get_sock() will fail and MP_JOIN will fail too, incrementing
>> MPTCP_MIB_JOINNOTOKEN.
>
> I'm looking at the above issue.
>
> I think we can address it allocating earlier the msk socket in
> subflow_syn_recv_sock(), so that we can always insert the 'token ->
> msk' association into the radix tree before entering the fully
> established status.
>
> As a nice side effect mptcp_connect() will be simpler and faster.
>
> The flip side is more memory allocated for the child socket backlog (I
> think it should not be that bad, as the child backlog is limited).
>
> I hope to share some early code soon. (will be a separate series
> anyway)
>
> Any comments/opinion/warns ?!?
>

Would it work to do the allocation in mptcp_stream_accept() instead of =

subflow_syn_recv_sock() to avoid the backlog issue? At that point you know =

the server is accepting the connection, and it looks like the msk lock =

isn't held yet so you still have some flexibility there.


Also - I did look through the full patch set and just had the comments on =

patch 4.

--
Mat Martineau
Intel
--===============8802949246081988639==--

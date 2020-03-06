Content-Type: multipart/mixed; boundary="===============1513712203428232050=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/12] pm netlink: followup and fixes
Date: Thu, 05 Mar 2020 17:37:49 -0800
Message-ID: <alpine.OSX.2.22.394.2003051735400.45396@mlee22-mobl.amr.corp.intel.com>
In-Reply-To: cover.1583418571.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3888

--===============1513712203428232050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 5 Mar 2020, Paolo Abeni wrote:

> This series bring some fixes and improvement related to the PM netlink,
> specifically:
>
> - renames 4th_ack subflow field to 'fully_established':
>  this is hopefully more accurate
> - implements support to enforce the maximum number of subflows per msk
> - implements MP_JOIN 3rd ack retransmission and 4th ack delivery:
>  this [ab]use the TCP delack timer. I personally think the idea is nice a=
nd
>  avoids changes to the core TCP stack, but I guess it could be disputed
> - more accurare 'fully established' accounting as per RFC
> - drop the msk level 'fully_established' field, as we can use the first s=
ubflow
>  status without additional locking instead. This simplify core PM event
>  handling
> - adds more MP_JOIN related mib counters
> - update the PM netlink to enforce a configurable maximum number of subfl=
ows
>  per msk
> - extend the pm netlink self-tests to check the above APIs
> - uses amost all the above to fix the currently disable mp join self-test=
s and
> re-enable them
>
> Note: mp join self tests are still unstable, e.g. can fail randomly, due =
to an
> old race between mptcp_token_update_accept() and mptcp_token_get_sock(): =
e.g.
> a client may legitly try to create a subflow after that the first one is =
fully
> established but before the server has accepted the initial socket:
> mptcp_token_get_sock() will fail and MP_JOIN will fail too, incrementing
> MPTCP_MIB_JOINNOTOKEN.
> I think the above should be addressed in a separate series - otherwise th=
is one
> will be too big.
>
> The up2date branch for this series (v2) is available here:
>
> https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_7
>
> v1 -> v2:
> - comments and readability changes in patch 04
>

Thanks for the fixes - I don't have any further comments, looks good to =

integrate in the topgit tree.

--
Mat Martineau
Intel
--===============1513712203428232050==--

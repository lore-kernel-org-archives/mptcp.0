Content-Type: multipart/mixed; boundary="===============5345772701170380151=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "mptcp: refactor shutdown and
 close" again
Date: Fri, 13 Nov 2020 20:18:18 +0100
Message-ID: <838c3a9c-014e-4a73-e389-ce6eb3469fbe@tessares.net>
In-Reply-To: 39ea7742090de819ba148c17aa133481ade5ba85.1605290282.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6725

--===============5345772701170380151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 13/11/2020 19:05, Paolo Abeni wrote:
> fix bad mask and fallback state tracking on shutdown
> and close.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> v1 -> v2:
>   - more fallback status fixes
> =

> Note:
> - fallback status tracking at close time was almost completely
> broken. I suspect that was quite hidden by the worker that somehow
> spooled the data and closed the socket with time. With workqueue
> removale it's very apparent.
> - this replaces completely the previous version (is not an incremental
> change)

Thank you for this new version and fixing + cleaning that part!

- 349d70b5a824: Revert "Squash-to: "mptcp: refactor shutdown and close" =

again" topic
- 58c8d69fda40: "squashed" (with conflicts) in "Squash-to: "mptcp: =

refactor shutdown and close" again"
     The conflict was in mptcp_check_data_fin(), see below
- d8578f2014ae: conflict in =

t/mptcp-send-explicit-ack-on-delayed-ack_seq-incr
- Results: 8ad8e1a1ec77..245521ccb46e

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5345772701170380151==--

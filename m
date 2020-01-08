Content-Type: multipart/mixed; boundary="===============0654967561253050659=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Rebase request
Date: Wed, 08 Jan 2020 10:25:51 +0100
Message-ID: <fbda52a2-9706-8509-a193-f1b9ab3d48d9@tessares.net>
In-Reply-To: ce14a20b5fe57043948993ed09d5e1451bbf9a4a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3286

--===============0654967561253050659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 08/01/2020 09:22, Paolo Abeni wrote:
> On Tue, 2020-01-07 at 17:31 -0800, Peter Krystad wrote:
>> I would like to switch the order of the two commits: "Add path manager
>> interface" and "Add ADD_ADDR handling". The addition of ADD_ADDR option
>> handling and adding the path manager interface is muddled between these =
two
>> commits, this switch will clean this up and make further patches for
>> optimizing mptcp_options_received structure cleaner.
>>
>> I've done the work here:
>>
>> https://github.com/pkrystad/mptcp_net-next/tree/switched-0107
> =

> I agree the code is cleaner/clearer this way, LGTM!

Thank you for the rebase and the review!

"mptcp: Add path manager interface" topic:

- eafbb1db164d: tg: revert t/mptcp-Add-path-manager-interface

"mptcp: Add ADD_ADDR handling" topic:

- b1bc561674d7: conflict in t/mptcp-Add-ADD_ADDR-handling
- 8960e50e483e: mptcp:options: remove PM part
- 3be7f0d27220: tg: now depends on t/mptcp-cope-with-later-TCP-fallback

"mptcp: Add path manager interface" topic:

- 991423c2cb16: tg: now depends on t/mptcp-Add-ADD_ADDR-handling
- f2c4091bab23: Revert "tg: revert t/mptcp-Add-path-manager-interface"
- 13ce67bc877b: Revert "mptcp:options: remove PM part"

"mptcp: Add handling of incoming MP_JOIN requests" topic:

- f0ecd83da95e: tg: now depends on t/mptcp-Add-path-manager-interface

t/upstream:

- 39373958a458..d2cef9d0ec37: result

Remaining diff:

=3D=3D=3D=3D=3D=3D=3D

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ead95592d9eb..aec7ecd1d709 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -147,8 +147,8 @@ struct mptcp_sock {
         struct skb_ext  *cached_ext;    /* for the next sendmsg */
         struct socket   *subflow; /* outgoing =

connect/listener/!mp_capable */
         struct sock     *first;
-       struct mptcp_pm_data    pm;
         u8              addr_signal;
+       struct mptcp_pm_data    pm;
  };

  #define mptcp_for_each_subflow(__msk, __subflow)                       \

=3D=3D=3D=3D=3D=3D=3D

I kept this as it seems to better reflect the new commit order, plus we =

keep the alignment up to the last item and we add the inclusion of the =

PM structure at the end.

Tell me if you prefer to change this.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0654967561253050659==--

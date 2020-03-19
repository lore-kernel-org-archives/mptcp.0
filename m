Content-Type: multipart/mixed; boundary="===============5730663782953079906=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/3] MP_JOIN self-tests fixes
Date: Thu, 19 Mar 2020 18:58:13 +0100
Message-ID: <15b796cf-478d-a510-8a10-ebbffe1392eb@tessares.net>
In-Reply-To: 2966ece542d3bc3ec5e904f137890ca09d6578ad.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3993

--===============5730663782953079906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 16/03/2020 19:06, Paolo Abeni wrote:
> On Mon, 2020-03-16 at 16:09 +0100, Paolo Abeni wrote:
>> This series addresses the currently known issues in MP_JOIN self-tests.
>>
>> Due to some races, without these patches I observe intermittent failures=
 (say
>> 1 out of 3 self-tests fail). With this patches applied, self-tests survi=
ved
>> ~200 iterations successfully.
>>
>> See individual patches for the details.
>>
>> On top of "mptcp: move msk state update to subflow_syn_recv_sock()"
> =

> Just for reference, the current export branch
> (@1016c1ca454a2f19075f1d0c4925c35f698b6f8c) + "mptcp: move msk state
> update to subflow_syn_recv_sock()" + these patches is available at:
> =

> https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_10

Thank you for the patches and the reviews!

- c4615f515b41: "squashed" patch 1/3 in "mptcp: Implement path manager =

interface commands"
- 5257c21d9804: conflict in =

t/mptcp-implement-and-use-MPTCP-level-retransmission
- b2fc8ed9ca5f: conflict in t/mptcp-add-netlink-based-PM
- ca158067259a..ef5d4d25c399: result

- a49945862c4d: "squashed" patch 2/3 in "mptcp: add netlink based PM"
- ef5d4d25c399..152845a286fa: result

- 89d9a90d57ec: "squashed" patch 3/3 in "selftests: add test-cases for =

MPTCP MP_JOIN"
- 152845a286fa..6854e267eb38: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5730663782953079906==--

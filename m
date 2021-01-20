Content-Type: multipart/mixed; boundary="===============3145015369071348458=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 2/7] mptcp: move pm netlink work into
 pm_netlink
Date: Wed, 20 Jan 2021 12:38:56 +0100
Message-ID: <6e322898-ca0e-c556-deee-baf018167501@tessares.net>
In-Reply-To: afb06ec6-793f-81d3-733c-fc115f9b30b1@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7439

--===============3145015369071348458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 20/01/2021 01:27, Mat Martineau wrote:
> On Thu, 14 Jan 2021, Florian Westphal wrote:
> =

>> allows to make some functions static and avoids aquire of the pm spinlock
>> in protocol.c.
>>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
>> net/mptcp/pm_netlink.c | 45 +++++++++++++++++++++++++++++++++++++-----
>> net/mptcp/protocol.c=C2=A0=C2=A0 | 33 +------------------------------
>> net/mptcp/protocol.h=C2=A0=C2=A0 |=C2=A0 6 +-----
>> 3 files changed, 42 insertions(+), 42 deletions(-)
>>
> =

> Also ok with me to apply this to the export branch.

Thank you for the patches and the reviews!

Just added the two first patches in our tree with Mat's RvB tag (and I =

fixed a typo in the commit message reported by codespell):

- 168b68baccfa: mptcp: pm: add lockdep assertions
- 6df8f68967a5: mptcp: move pm netlink work into pm_netlink
- Results: a1d71a555f36..44215ba71300

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3145015369071348458==--

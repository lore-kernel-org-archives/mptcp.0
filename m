Content-Type: multipart/mixed; boundary="===============6290324914192993488=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/9] mptcp: cope better with mp_join storm
Date: Mon, 13 Jul 2020 08:40:07 +0200
Message-ID: <f5681411-f7cf-f769-47a1-76a90ea99951@tessares.net>
In-Reply-To: 20200710213512.GD60489@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4991

--===============6290324914192993488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat, Christoph,

On 10/07/2020 23:35, Christoph Paasch wrote:
> On 07/10/20 - 11:31, Mat Martineau wrote:
>>
>> On Fri, 10 Jul 2020, Paolo Abeni wrote:
>>
>>> This is a rebase of the RFC, dropping old 5/5 and including a few somew=
hat
>>> related bugfixes - all targeting net-next because the fixed commit is o=
nly
>>> there or the buggy behavior can be triggered only enabling non backup s=
ubflows

...

>> Thanks Paolo, the changes look good. Should these go in mptcp_net-next f=
or a
>> testing pass before upstreaming?
> =

> I picked these patches on top of export and am running syzkaller on top of
> it. I will try to do an mptcp.org-interop run later or Monday.
These patches are in the "export" branches with these tags:

   Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
   Tested-by: Christoph Paasch <cpaasch(a)apple.com>

Please tell me if you wish me to change this.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6290324914192993488==--

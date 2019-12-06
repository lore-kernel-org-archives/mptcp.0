Content-Type: multipart/mixed; boundary="===============5698704548046034082=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] MAINTAINERS: Add MPTCP maintainer
Date: Fri, 06 Dec 2019 09:22:29 -0800
Message-ID: <alpine.OSX.2.21.1912060917340.71273@pminglan-mobl.amr.corp.intel.com>
In-Reply-To: 7a92d4d9679f268eefc3189675ca76a0e27c9143.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2833

--===============5698704548046034082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2019, Davide Caratti wrote:

> On Thu, 2019-12-05 at 15:05 -0800, Mat Martineau wrote:
>> When we discussed maintainership in an earlier meeting
>> (https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/HCII26=
22GWZCOMQCBOMQBJKZI247YIH5/)
>> there was a loose consensus that it would be best to have multiple
>> maintainers. I nominate Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> as a co-maintainer, what do you think?
>>
>> squashto: mptcp: Add MPTCP to skb extensions
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  MAINTAINERS | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> hello Mat,
>
> I think that the "maintainership" also applies to the UAPI bits, so
> probably we should add
>
> include/uapi/linux/mptcp.h
>
> correct?
>

Thanks for pointing this out, I'll send another patch for uapi. I missed =

that one because I only looked at the "part 1 & 2" commits.

--
Mat Martineau
Intel
--===============5698704548046034082==--

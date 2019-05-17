Content-Type: multipart/mixed; boundary="===============8957276408822996640=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC mptcp 2/2] mptcp: allow dumping subflow
 context to userspace
Date: Fri, 17 May 2019 10:30:59 +0200
Message-ID: <9776e7af-4007-c002-4ef5-01fc4a378309@tessares.net>
In-Reply-To: alpine.OSX.2.21.1905161632570.41252@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1195

--===============8957276408822996640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Davide,

Thank you for the review and the patches!

On 17/05/2019 01:51, Mat Martineau wrote:
> =

> On Tue, 14 May 2019, Davide Caratti wrote:
> =

>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>> new file mode 100644
>> index 000000000000..bba74a97e6c2
>> --- /dev/null
>> +++ b/include/uapi/linux/mptcp.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>> +#ifndef _UAPI_MPTCP_H
>> +#define _UAPI_MPTCP_H
>> +
>> +#include <linux/types.h>
>> +
>> +#define SUBFLOW_FLAGS_MP_REMOTE BIT(0)
>> +#define SUBFLOW_FLAGS_MP_LOCAL=C2=A0 BIT(1)
>> +#define SUBFLOW_FLAGS_DSS_CSUM=C2=A0 BIT(2)
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 MPTCP_SUBFLOW_LOCAL_KEY,
>> +=C2=A0=C2=A0=C2=A0 MPTCP_SUBFLOW_REMOTE_KEY,
>> +=C2=A0=C2=A0=C2=A0 MPTCP_SUBFLOW_FLAGS,
>> +=C2=A0=C2=A0=C2=A0 MPTCP_SUBFLOW_PAD,
>> +=C2=A0=C2=A0=C2=A0 __MPTCP_SUBFLOW_MAX
>> +};
> =

> The 32-bit subflow->token is also useful, since that's what would be
> relevant for future MP_JOIN attempts.

Just a small note to say that it is not recommended to expose this token
to regular users for security reasons. Please see this (famous --
Christoph would remember it :) ) commit from mptcp.org:


https://github.com/multipath-tcp/mptcp/commit/e993b775d8abda232ceecbbed135b=
40c546f5088

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8957276408822996640==--

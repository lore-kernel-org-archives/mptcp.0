Content-Type: multipart/mixed; boundary="===============6720605476759271175=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: harmonize locking on all socket
 operations.
Date: Tue, 23 Jul 2019 19:18:15 +0200
Message-ID: <7f98f297-1563-2a96-a7b8-729808c9512e@tessares.net>
In-Reply-To: df008864fc44adbcadcf5b94ad104db97833ac1a.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1544

--===============6720605476759271175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Peter, Mat,

On 18/07/2019 19:55, Peter Krystad wrote:
> =

> v2 change looks good to me.
> =

> Peter.
> =

> =

> =

> On Thu, 2019-07-11 at 18:48 +0200, Paolo Abeni wrote:
>> The locking schema implied by sendmsg(), recvmsg(), etc.
>> requires acquiring the msk's socket lock before manipulating
>> the msk internal status.
>>
>> Additionally, we can't acquire the msk->subflow socket lock while holding
>> the msk lock, due to mptcp_finish_connect().
>>
>> Many socket operations do not enforce the required locking, e.g. we have
>> several patterns alike:
>>
>> 	if (msk->subflow)
>> 		// do something with msk->subflow
>>
>> or:
>>
>> 	if (!msk->subflow)
>> 		// allocate msk->subflow
>>
>> all without any lock acquired.
>>
>> They can race with each other and with mptcp_finish_connect() causing
>> UAF, null ptr dereference and/or memory leaks.
>>
>> This patch ensures that all mptcp socket operations access and manipulate
>> msk->subflow under the msk socket lock. To avoid breaking the locking
>> assumption introduced by mptcp_finish_connect(), while avoiding UAF
>> issues, we acquire a reference to the msk->subflow, where needed.
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>>  v1 -> v2:
>>  - fix msk->subflow misusage in mptcp_getsockopt()
>>
>> rfc -> v1:
>>  - rename *mptcp_socket_get_ref() as *mptcp_fallback_get_ref()
>>  - use subflow_create_socket() in mptcp_socket_create_get() instead
>>    of open-codying it.
>>  - use mptcp_fallback_get_ref() instead of mptcp_socket_create_get() in
>>    mptcp_stream_accept()

Thank you for the patch and the reviews!

Just applied at the end of the patch series.

Compilation is still OK.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6720605476759271175==--

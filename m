Content-Type: multipart/mixed; boundary="===============0318556316437618371=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 03/12] mptcp: Add mptcp_close_state()
 helper
Date: Fri, 17 Jul 2020 11:07:06 -0700
Message-ID: <alpine.OSX.2.23.453.2007171105190.39222@kdpetti-mobl.amr.corp.intel.com>
In-Reply-To: dbd09873ffb51e8436feabd0af5340e827b03996.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5085

--===============0318556316437618371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2020, Paolo Abeni wrote:

> On Wed, 2020-07-15 at 17:20 -0700, Mat Martineau wrote:
>> This will be used to transition to the appropriate state on close and
>> determine if a DATA_FIN needs to be sent for that state transition.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  net/mptcp/protocol.c | 28 +++++++++++++++++++++++++++-
>>  1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 7cdf451ea3da..69100187490f 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1424,7 +1424,33 @@ static void mptcp_subflow_shutdown(struct sock *s=
sk, int how,
>>  	release_sock(ssk);
>>  }
>>
>> -/* Called with msk lock held, releases such lock before returning */
>
> Beware! this removes the above commit message, likely in an unintended
> way.
>

Looks like I didn't split this commit correctly. The comment looked =

invalid since the msk lock is aquired at the beginning of mptcp_close, if =

the function was called with the msk lock held it would deadlock.

--
Mat Martineau
Intel
--===============0318556316437618371==--

Content-Type: multipart/mixed; boundary="===============4070994940799785731=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 12/12] mptcp: Safely store sequence
 number when sending data
Date: Fri, 17 Jul 2020 12:16:08 -0700
Message-ID: <alpine.OSX.2.23.453.2007171151490.39222@kdpetti-mobl.amr.corp.intel.com>
In-Reply-To: f6a1927611c1aad78b179ff87e1205065a72cd9e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5090

--===============4070994940799785731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2020, Paolo Abeni wrote:

> On Wed, 2020-07-15 at 17:20 -0700, Mat Martineau wrote:
>> The MPTCP socket's write_seq member can be read without the msk lock
>> held, so use WRITE_ONCE() to store it.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  net/mptcp/protocol.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 30c5810771dd..ed3ca80d72f8 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -797,7 +797,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
>>  out:
>>  	if (!retransmission)
>>  		pfrag->offset +=3D frag_truesize;
>> -	*write_seq +=3D ret;
>> +	WRITE_ONCE(*write_seq, *write_seq + ret);
>>  	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
>
> I think the msk lock should be already held here ?!?

Yes, but write_seq might be concurrently read by another CPU, and we want =

don't want the compiler to invent stores as described in =

memory-barriers.txt

My (possibly flawed?) understanding of READ_ONCE/WRITE_ONCE has led me to =

these rules of thumb:

  * Always use WRITE_ONCE to avoid storing weird intermediate values that =

can be seen by concurrent readers

  * For values that are only written with the lock held, but have =

concurrent readers, READ_ONCE only required when not locked. The compiler =

will correctly synchronize with any readers/writers on the same locked =

thread.

  * For values that have writes without the lock held (access is not =

coordinated by locks at all), always use READ_ONCE. The compiler doesn't =

know when any write will update the memory location.



I know the full story for READ_ONCE/WRITE_ONCE syncronization is more =

complicated, but for the way we've been using them in MPTCP it seems like =

the above rules work ok. If I'm mistaken I'd really like to fix that so =

I write correct code :)



--
Mat Martineau
Intel
--===============4070994940799785731==--

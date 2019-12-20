Content-Type: multipart/mixed; boundary="===============3310060370771504890=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 05/11] tcp,
 ulp: Add clone operation to tcp_ulp_ops
Date: Fri, 20 Dec 2019 08:26:06 -0800
Message-ID: <2c5e98ae-f563-f6b4-b09c-ef0e0a12ffa5@gmail.com>
In-Reply-To: 1563cacb2fb2f5c59bedc7a33667586d4c3ec6c5.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3228

--===============3310060370771504890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/20/19 8:21 AM, Paolo Abeni wrote:
> On Fri, 2019-12-20 at 07:26 -0800, Eric Dumazet wrote:
>>
>> On 12/19/19 2:34 PM, Mat Martineau wrote:
>>> If ULP is used on a listening socket, icsk_ulp_ops and icsk_ulp_data are
>>> copied when the listener is cloned. Sometimes the clone is immediately
>>> deleted, which will invoke the release op on the clone and likely
>>> corrupt the listening socket's icsk_ulp_data.
>>>
>>> The clone operation is invoked immediately after the clone is copied and
>>> gives the ULP type an opportunity to set up the clone socket and its
>>> icsk_ulp_data.
>>>
>>
>> Since the method is void, this means no error can happen.
>>
>> For example we do not intend to attempt a memory allocation ?
> =

> if the MPTCP ULP clone fails, we fallback to plain TCP (the 'is_mptcp'
> flag cleared on the tcp 'struct sock'), so we don't have an error
> return code there.
> =

> If we change the 'clone' signature, than the only in-kernel user will
> always return 0, would that be ok?

I guess you could simply add more comments in the changelog for the time be=
ing.

I was trying to make sure we would not have later another patch changing
the signature.
--===============3310060370771504890==--

Content-Type: multipart/mixed; boundary="===============1777782345028962214=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: inet_diag: support for wider protocol
 numbers
Date: Thu, 09 Jul 2020 10:31:11 +0200
Message-ID: <93654ac4-2296-b714-9617-fd052c00d743@tessares.net>
In-Reply-To: 2c610659c6c6c1acaa452e8363853e6560fc3882.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4954

--===============1777782345028962214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph, Paolo,

On 08/07/2020 12:28, Paolo Abeni wrote:
> On Tue, 2020-07-07 at 17:01 -0700, Christoph Paasch wrote:
>> Now running syzkaller with lockdep enabled:
>> Syzkaller hit 'WARNING: bad unlock balance in inet_diag_cmd_exact' bug.

...

>> inet_diag_lock_handler is supposed to exit always with the lock held.
>> So, even if proto is out-of-bounds let's take the lock.
>>
>> Another way to fix that would be to teach to the callers whether or not
>> inet_diag_lock_handler ended up taking the lock or not (by returning
>> -EINVAL instead). But that looks more brittle to me as the intention of
>> inet_diag_lock_handler really is to take the lock.
> =

> Agreed, looks better this way.

Thank you for the patch and the review!

- cb46e21d1f7f: "squashed" in "inet_diag: support for wider protocol =

numbers"
- f0bfb9c8a333..287977a070ee: result

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1777782345028962214==--

Content-Type: multipart/mixed; boundary="===============2890140630646079540=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: fix 'assignment from incompatible
 pointer type' warning
Date: Fri, 11 Oct 2019 18:08:47 +0200
Message-ID: <d9d38839-fe44-f6b9-17ed-323f5bef997e@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910101722160.68386@crpeter1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2098

--===============2890140630646079540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/10/2019 02:28, Mat Martineau wrote:
> On Thu, 10 Oct 2019, Paolo Abeni wrote:
> =

>> when building vs 32 bits arches pfrag->offset is 16bits , otherwise 32.
>> Instead of using conditional definitions in multiple places, let's
>> drop 'poffset' variable altogether.
>>
>> sendmsg_frag() updates only the pfrag offset, if pfrag is available,
>> while dfrag offset update is up to the caller.
>>
> =

> Looks good to me. Thanks for the fix and remembering to check the 32-bit =

> build.

Thank you for the patch and the review!

It seems I add to apply it in 2 parts:

- 2d04d60715f3: "squashed" (part 1) in "mptcp: rework mptcp_sendmsg_frag =

to accept optional dfrag"
- 134ba5eb5cc1: "squashed" (part 2) in "mptcp: implement and use =

MPTCP-level retransmission"
- 9692b7db4cfb..c4908614f7c5: result

> Matthieu, you were asking about build automation suggestions. A 32-bit =

> build could be helpful!

Good idea, just added in the list of ideas! (I guess I will also have to =

catch warnings, I don't think I do that for the moment).

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2890140630646079540==--

Content-Type: multipart/mixed; boundary="===============0966308935272273899=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: One more squash
Date: Wed, 09 Oct 2019 09:44:54 +0200
Message-ID: <31be82a2-b829-15dd-b418-27ebf04c19c0@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910081729540.41156@crpeter1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2066

--===============0966308935272273899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 09/10/2019 02:30, Mat Martineau wrote:
> =

> On Tue, 8 Oct 2019, Mat Martineau wrote:
> =

>>
>> With Florian's branch as a basis:
>>
>> https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dexport_sendmsg=
_rebase_13
>>
>>
>> I've squashed one more patch out of the series. "mptcp: Make MPTCP
>> socket block/wakeup ignore sk_receive_queue" has been combined with
>> "mptcp: Implement MPTCP receive path". The diff of the full series is
>> unchanged.
> =

> The repo link would help you all out:
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?=
h=3Dmptcp-wakeup-squash

Thank you for this new squash! Looks good to me.

If there is no objection, I will re-create the tree using your branch,
re-sync on latest net-next, check everything is OK and tag.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0966308935272273899==--

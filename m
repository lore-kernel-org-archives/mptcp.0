Content-Type: multipart/mixed; boundary="===============7296138474517443161=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v4 00/12] DATA_FIN support
Date: Tue, 28 Jul 2020 09:37:57 -0700
Message-ID: <alpine.OSX.2.23.453.2007280936080.45676@joses-mobl6.amr.corp.intel.com>
In-Reply-To: 3082c3f5-b17d-c6a9-6966-cbf06ff97b8c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5342

--===============7296138474517443161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jul 2020, Matthieu Baerts wrote:

> Hi Mat, Paolo,
>
> On 24/07/2020 03:11, Mat Martineau wrote:
>> Here is a series adding full DATA_FIN support at connection shutdown /
>> close. See the patch 8 commit message for information about the
>> disconnection state machine.
>> =

>> Self tests are passing. Have now checked interoperation with the
>> mptcp_trunk branch.
>
> Thank you for the new v4 and the reviews!
>
> As discussed on IRC, I added these patches at the end of the export branc=
h.
>
> Note that I move:
> - "mptcp: Add mptcp_close_state() helper"
> - "mptcp: Track received DATA_FIN sequence number and add related helpers"
> - "07aac58e4c66 mptcp: Add helper to process acks of DATA_FIN"
> just before "mptcp: Use full MPTCP-level disconnect state machine" and sk=
ip =

> these commits from the "per-commit" validation tests because new static =

> functions are added without users.
>
> Tests + export are in progress!
>

I'd like to send this to netdev soon (today maybe?). Can I add any =

Acked-by tags first?

Thanks,

--
Mat Martineau
Intel
--===============7296138474517443161==--

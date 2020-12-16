Content-Type: multipart/mixed; boundary="===============6568165338928662811=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 net-next] mptcp: clear use_ack and
 use_map when dropping other suboptions
Date: Tue, 15 Dec 2020 16:09:12 -0800
Message-ID: <a7a197aa-324-025-1d15-42f3d3dc885e@linux.intel.com>
In-Reply-To: 555bf51-4246-4dee-41f-fdaa7e45713a@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7176

--===============6568165338928662811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Dec 2020, Mat Martineau wrote:

>
> On Tue, 15 Dec 2020, Geliang Tang wrote:
>
>> This patch cleared use_ack and use_map when dropping other suboptions to
>> fix the following syzkaller BUG:
>>

...

>> ---
>> net/mptcp/options.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> =

>
> Thanks for the fix!
>
> As Paolo mentioned, please send this to netdev for the -net tree. The -ne=
t =

> branch is now up to date with the net-next branch and Linus' merge of =

> net-next for 5.11 so thte branch is ready for this fix.
>
> Please add my tag:
>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

I hadn't seen that you sent to netdev already - although the patch is =

tagged for net-next instead of the net tree. I will reply there and maybe =

Jakub or David will apply to net or follow up with a reply or patchwork =

status update.

--
Mat Martineau
Intel
--===============6568165338928662811==--

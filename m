Content-Type: multipart/mixed; boundary="===============6042713997402123776=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/9] RM_ADDR: remove a list
 of addrs
Date: Mon, 08 Feb 2021 17:57:51 -0800
Message-ID: <5764998f-17f1-ece6-e8c5-8a2d758c864@linux.intel.com>
In-Reply-To: cover.1612795651.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7694

--===============6042713997402123776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 8 Feb 2021, Geliang Tang wrote:

> v5:
> - use struct mptcp_rm_list instead of the ids array.
> - simplify mptcp_pm_remove_addrs_and_subflows.
> - apply: tag export/20210207T062839 + patchset "move to next addr and
> testcases".
>

Thanks Geliang!

I only had a couple of minor comments doing visual code review, they =

affect individual patches but not the final code. That's all I saw in =

visual code review, I will look at the test output and pcaps tomorrow.

Have you tested what happens if there's an incoming rm_addr with id 0, =

since we never send an ADD_ADDR for the initial subflow?

--
Mat Martineau
Intel
--===============6042713997402123776==--

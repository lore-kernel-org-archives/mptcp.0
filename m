Content-Type: multipart/mixed; boundary="===============2142838222445553557=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 5/6] mptcp: add a new sysctl
 add_addr_timeout
Date: Mon, 02 Nov 2020 16:35:18 -0800
Message-ID: <49dec7ac-934a-2fe6-70ef-71f7b3ed2f@linux.intel.com>
In-Reply-To: 20201102153359.29c546f1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net
X-Status: 
X-Keywords:                  
X-UID: 6517

--===============2142838222445553557==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2020, Jakub Kicinski wrote:

> On Fri, 30 Oct 2020 15:45:05 -0700 Mat Martineau wrote:
>> From: Geliang Tang <geliangtang(a)gmail.com>
>>
>> This patch added a new sysctl, named add_addr_timeout, to control the
>> timeout value (in seconds) of the ADD_ADDR retransmission.
>
> Please document the new sysctl.
>

Thanks Jakub. I will add a patch to document this new sysctl and the =

existing 'enabled' sysctl for MPTCP.

--
Mat Martineau
Intel
--===============2142838222445553557==--

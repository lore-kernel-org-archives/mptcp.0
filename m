Content-Type: multipart/mixed; boundary="===============0142265573660729217=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash-to: "mptcp: remove
 addr and subflow in PM netlink v9" Part 2
Date: Fri, 18 Sep 2020 14:04:00 +0200
Message-ID: <336af1d5-73a7-599f-2d0b-5aea68f00e5f@tessares.net>
In-Reply-To: CA+WQbwvohxAyiis46R+E4GVE7qRFHLDjhPzoEjBgJ0wSHWmMSg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5928

--===============0142265573660729217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 18/09/2020 04:48, Geliang Tang wrote:
> Hi Matt,
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=
=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:10=E5=86=99=E9=
=81=93=EF=BC=9A
>>
>> Hi Geliang, Paolo,
>>
>> On 17/09/2020 12:12, Paolo Abeni wrote:
>>> On Thu, 2020-09-17 at 17:19 +0800, Geliang Tang wrote:
>>>> This patch fixed BUG in mptcp_pm_free_anno_list(). mptcp_pm_free_anno_=
list
>>>> may be called when PM has not been inited, then we'll get the "NULL po=
inter
>>>> dereference" BUG.
>>>>
>>>> This patch moved __mptcp_init_sock call before the !mptcp_is_enabled()
>>>> check in mptcp_init_sock(). No matter mptcp is enabled or not, we all
>>>> called __mptcp_init_sock to init the mptcp socket.
>>>>
>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/90
>>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>>>
>>> LGTM, thanks!
>>
>> Thank you for this patch and the review!
>>
>> - 3704fca5b32c: "squashed" in "mptcp: remove addr and subflow in PM netl=
ink"
>> - ed4dddf22888..6ffedca7e3d7: result
> =

> Since we squash two patches to commit "mptcp: remove addr and subflow
> in PM netlink",
> please update its commit message entirely like this:
> =

> '''
> This patch implements the remove announced addr and subflow logic in PM
> netlink.
> =

> When the PM netlink removes an address, we traverse all the existing msk
> sockets to find the relevant sockets.
> =

> We add a new list named anno_list in mptcp_pm_data, to record all the
> announced addrs. In the traversing, we check if it has been recorded.
> If it has been, we trigger the RM_ADDR signal.
> =

> We also check if this address is in conn_list. If it is, we remove the
> subflow which using this local address.
> =

> Since we call mptcp_pm_free_anno_list in mptcp_destroy, we need to move
> __mptcp_init_sock before the mptcp_is_enabled check in mptcp_init_sock.
> '''

Thank you for checking that.

I indeed forgot to update the commit message as requested.
This is now done:

- 1aca645292c4: tg:msg: new msg for "mptcp: remove addr and subflow in =

PM netlink"

"export" branch has already been updated.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0142265573660729217==--

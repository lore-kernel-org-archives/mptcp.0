Content-Type: multipart/mixed; boundary="===============4193134575897392595=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash-to: "mptcp: remove
 addr and subflow in PM netlink v9" Part 2
Date: Thu, 17 Sep 2020 16:10:21 +0200
Message-ID: <b30f982b-eabd-260b-d758-299a51761c74@tessares.net>
In-Reply-To: 80b94c083e968672f79142d4be98d4b9f50ae636.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5916

--===============4193134575897392595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 17/09/2020 12:12, Paolo Abeni wrote:
> On Thu, 2020-09-17 at 17:19 +0800, Geliang Tang wrote:
>> This patch fixed BUG in mptcp_pm_free_anno_list(). mptcp_pm_free_anno_li=
st
>> may be called when PM has not been inited, then we'll get the "NULL poin=
ter
>> dereference" BUG.
>>
>> This patch moved __mptcp_init_sock call before the !mptcp_is_enabled()
>> check in mptcp_init_sock(). No matter mptcp is enabled or not, we all
>> called __mptcp_init_sock to init the mptcp socket.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/90
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> =

> LGTM, thanks!

Thank you for this patch and the review!

- 3704fca5b32c: "squashed" in "mptcp: remove addr and subflow in PM netlink"
- ed4dddf22888..6ffedca7e3d7: result

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4193134575897392595==--

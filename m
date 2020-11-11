Content-Type: multipart/mixed; boundary="===============3346565347802527534=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH][next] mptcp: fix a dereference of pointer before
 msk is null checked.
Date: Wed, 11 Nov 2020 19:23:57 +0000
Message-ID: <e493452c-4dc1-d2b2-e05b-9bace72af2dc@canonical.com>
In-Reply-To: cb9fba1-b399-325f-c956-ede9da1b1b7@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6661

--===============3346565347802527534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/11/2020 18:49, Mat Martineau wrote:
> On Mon, 9 Nov 2020, Colin King wrote:
> =

>> From: Colin Ian King <colin.king(a)canonical.com>
>>
>> Currently the assignment of pointer net from the sock_net(sk) call
>> is potentially dereferencing a null pointer sk. sk points to the
>> same location as pointer msk and msk is being null checked after
>> the sock_net call.=C2=A0 Fix this by calling sock_net after the null
>> check on pointer msk.
>>
>> Addresses-Coverity: ("Dereference before null check")
>> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
>> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
>> ---
>> net/mptcp/pm_netlink.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
> =

> Hi Colin and Jakub -
> =

> I noticed that the follow-up discussion on this patch didn't go to the
> netdev list, so patchwork did not get updated.
> =

> This patch is superseded by the following, which already has a
> Reviewed-by tag from Matthieu:
> =

> http://patchwork.ozlabs.org/project/netdev/patch/078a2ef5bdc4e3b2c25ef852=
461692001f426495.1604976945.git.geliangtang(a)gmail.com/
> =

> =

OK, thanks for letting me know. Good to see it got fixed!

Colin
> =

> Thanks!
> =

> -- =

> Mat Martineau
> Intel

--===============3346565347802527534==--

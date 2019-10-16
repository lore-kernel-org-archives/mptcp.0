Content-Type: multipart/mixed; boundary="===============8641652646110570120=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Wed, 16 Oct 2019 12:02:57 +0200
Message-ID: <bee4e601-1a38-38e4-6152-212bf17a1e96@tessares.net>
In-Reply-To: b5f1f0fcc2063a30c6ff9fe73d16a81643ac24ac.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2169

--===============8641652646110570120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/10/2019 10:58, Paolo Abeni wrote:
> On Wed, 2019-10-16 at 10:37 +0200, Matthieu Baerts wrote:
>> On 16/10/2019 10:22, Paolo Abeni wrote:
>>> Yes, I'm cooking patch && rebase right now. I hopefully will send soon
>>> v2 of the patches with a reference to the rebase branch in the cover
>>> letter.
>>
>> If you only adds the line mentioned by Mat, I am fine if you update your
>> branch directly, no need to send new patches that we will not use
>> directly
> =

> The new rebase branch is:
> =

> https://github.com/pabeni/mptcp/tree/mptcp-proposal-recvmsg_rebase_8

Great. I just used it to re-create the tree (not the export branch yet).

[...]

> It's based on top of net-next commit 77ffe33363c0 ("hv_sock: use
> HV_HYP_PAGE_SIZE for Hyper-V communication")

Thank you for this rebase!

> I checked for build issue only on the modified patches.

I just asked the CI to validate each commit before doing the export.
I will notify you if there is an issue. With the build queue, it might =

take ~1 hour.

>> , a diff is fine :-)
> =

> I'm sorry, I'm unsure what I should diff !?!
> =

> Anyhow, this is the diff vs. yday rebase branch/patches:
> =

> ---
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index b2fd57341889..b13548a0df1a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -402,7 +402,7 @@ static enum mapping_status
> get_mapping_status(struct sock *ssk)
>                   * real data_fin support
>                   */
>                  pr_debug("DATA_FIN with no payload");
> -               return MAPPING_OK;
> +               return MAPPING_DATA_FIN;
>          }
> =

>          if (!mpext->dsn64) {
> ---

Yes, this diff is good, thank you!

> And this is the diff vs the current export branch with the current
> recevmsg refactor changes applied - only whitespaces to tabs
> modifications:
> ---

[...]

> ---
> =

> Please let me know if something different is preferred and/or needed,
> thanks!

I have everything, thank you!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8641652646110570120==--

Content-Type: multipart/mixed; boundary="===============7130865997774631253=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 0/9] Changes for implementing MPTCP
Date: Wed, 28 Feb 2018 15:31:18 -0800
Message-ID: <00c397b0-db0e-6eb6-7e65-4e83c90ec694@oracle.com>
In-Reply-To: alpine.OSX.2.21.1802281436490.20016@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 326

--===============7130865997774631253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 02/28/2018 02:59 PM, Mat Martineau wrote:
> I have some more recommendations:
>
> =C2=A0* Include the new Kconfig modification to add CONFIG_MPTCP early in =

> the patch set
>
> =C2=A0* Make sure that all patches will build with the config option =

> enabled or disabled (all include files and symbols present, etc.)
>
> =C2=A0* Handle conditional compilation according to =

> https://www.kernel.org/doc/html/latest/process/coding-style.html#conditio=
nal-compilation =

>
>
> =C2=A0* Don't define callbacks in the data structure until there's code =

> that uses them
>
> =C2=A0* Craft commit messages and subject lines that will help the =

> reviewers understand the changes and what drives tham
>
>
> Even for RFC patch sets, the expectation is that thay will meet =

> submission guidelines:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> https://www.kernel.org/doc/html/latest/process/coding-style.html
> https://www.kernel.org/doc/html/latest/process/submit-checklist.html
>
>
> I think you'll help MPTCP ultimately arrive upstream by putting some =

> more work in to how this TCP architecture proposal is presented to the =

> netdev maintainers.
>
>
Thanks Mat. I will try to cleanup as much as I can and post it upstream.

Shoaib.


--===============7130865997774631253==--

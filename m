Content-Type: multipart/mixed; boundary="===============6205760480850576317=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] selftests: increase the new default timeout
Date: Fri, 25 Oct 2019 13:25:50 -0700
Message-ID: <alpine.OSX.2.21.1910251325130.64627@srpullel-mobl.amr.corp.intel.com>
In-Reply-To: 7d1fc384-6da9-c3a2-c36c-36e925a04228@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2325

--===============6205760480850576317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 25 Oct 2019, Matthieu Baerts wrote:

> Hi,
>
> On 23/10/2019 08:48, Matthieu Baerts wrote:
>> A new commit from upstream now sets a timeout of 45 seconds per test. =

>> That's
>> too low for MPTCP. We need more.
>> =

>> But increasing the timeout was not working because selftests scripts were
>> looking for this new 'settings' file in the wrong directory. I am going =
to =

>> send
>> the first patch upstream as it might be required for other selftests and =

>> not
>> specific to MPTCP.
>
> I hope you don't mind if I apply these 2 patches to be able to run the =

> selftests with the latest net-next. I propose to decrease the timeout val=
ue =

> later on when the new enhancements from Florian are applied.
>
> - ef0a0e4954b3: "squashed" patch 1/2 in "mptcp: add basic kselftest for =

> mptcp"
> - 3adea0746236: "squashed" patch 2/2 in "mptcp: add basic kselftest for =

> mptcp"
> - e2c9d4cc70f9..789fc73cc101: result
>

That plan sounds good, thanks for merging these.

--
Mat Martineau
Intel
--===============6205760480850576317==--

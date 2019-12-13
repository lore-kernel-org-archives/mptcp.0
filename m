Content-Type: multipart/mixed; boundary="===============8163414817062722239=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 01/11] net: Make sock protocol value checks more
 specific
Date: Fri, 13 Dec 2019 13:37:27 -0800
Message-ID: <alpine.OSX.2.21.1912131336340.33632@amhui-mobl1.amr.corp.intel.com>
In-Reply-To: de5d1de9-86fd-5538-f2e4-1c628ede7b6a@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3019

--===============8163414817062722239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 13 Dec 2019, Matthieu Baerts wrote:

> On 13/12/2019 21:48, Matthieu Baerts wrote:
>> From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> =

>> SK_PROTOCOL_MAX is only used in two places, for DECNet and AX.25. The
>> limits have more to do with the those protocol definitions than they do
>> with the data type of sk_protocol, so remove SK_PROTOCOL_MAX and use
>> U8_MAX directly.
>> =

>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>
> Oh, I just noticed my signed-off was added everywhere. That was not added=
 on =

> purpose. I didn't use any specific option for that but it's maybe due to =
my =

> git config:
>
>    [format]
>            signoff =3D true
>
> So please ignore my signed-off's :)

git send-email added those for you, no worries!

--
Mat Martineau
Intel
--===============8163414817062722239==--
